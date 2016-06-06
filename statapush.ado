/*
statapush: Stata module for sending push notifications
Authors: William L. Schpero and Vikram Jambulapati
Contact: william.schpero@yale.edu
Date: 060516
Version: 3.0
*/

capture program drop statapush
program define statapush
    version 12.1
    syntax [using/], Message(string) [Token(string) Userid(string)] [Attach(string)] [Provider(string)]

    * Load default preferences if token/userid not given
    if "`token'" == "" {
        _statapushprefgrab
        local token    "`r(token)'"
        local userid   "`r(userid)'"
        local provider "`r(provider)'"
    }

    * Pick pushcmd based on provider
    if "`provider'" == "" | lower("`provider'") == "pushover" {
        local pushcmd "_statapush"
    }
    else if lower("`provider'") == "pushbullet" {
        local pushcmd "_statapushbullet"
    }
    else if lower("`provider'") == "ifttt" {
        local pushcmd "_statapushifttt"
    }
    else {
        display as error "Invalid provider: `provider'. Need to use 'pushover', 'pushbullet', or 'ifttt'."
        exit 198
    }

    * Check whether attach specified correctly, if so reassign as an option
    if "`attach'" != "" & lower("`provider'") == "pushbullet" {
        local attach a("`attach'")
    }
    else if "`attach'" != "" & lower("`provider'") != "pushbullet" {
        display as error "Only 'pushbullet' supports 'attach'."
        exit 198
    }

    * Run the do file if "using" specified, otherwise just push message
    if "`using'" != "" {
        capture noisily do "`using'"
        if _rc == 0 {
            `pushcmd', t(`token') u(`userid') m(`message') `attach'
        }
        else {
            `pushcmd', t(`token') u(`userid') m("There's an error in `using'.")
        }
    }
    else {
        `pushcmd', t(`token') u(`userid') m(`message') `attach'
    }

end

* Pushover command
capture program drop _statapush
program define _statapush
    version 12.1
    syntax, Token(string) Userid(string) Message(string)
    quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=statapush" -F "message=`message'" https://api.pushover.net/1/messages.json
    display as text "Notification pushed at `c(current_time)' via Pushover"
end

* IFTTT command
capture program drop _statapushifttt
program define _statapushifttt
    version 12.1
    syntax, Token(string) Message(string) [Userid(string)]
    quietly !curl -X POST -H "Content-Type: application/json" -d "{\"value1\": \"StataPush\", \"value2\": \"`message'\"}" https://maker.ifttt.com/trigger/StataPush/with/key/`token'
    display as text "Notification pushed at `c(current_time)' via IFTTT"
end

* Pushbullet command
capture program drop _statapushbullet
program define _statapushbullet
    version 12.1
    syntax, Token(string) Message(string) [Userid(string)] [Attach(string)]
    if "`attach'" == "" {
        quietly !curl -u "`token'": -X POST https://api.pushbullet.com/v2/pushes --header "Content-Type: application/json" --data-binary "{\"type\": \"note\", \"title\": \"StataPush\", \"body\": \"`message'\"}"
    }
    else {
        quietly capture _uploadpushbullet, t("`token'") a("`attach'")
        if _rc == 601 {
            display as error "File not found: `attach'. Will attempt to notify without attachment."
            quietly !curl -u "`token'": -X POST https://api.pushbullet.com/v2/pushes --header "Content-Type: application/json" --data-binary "{\"type\": \"note\", \"title\": \"StataPush\", \"body\": \"`message'\"}"
        }
        else {
            local file_url "`r(file_url)'"
            local upload_url "`r(upload_url)'"
            local file_type "`r(file_type)'"
            quietly !curl --header "Access-Token: `token'" --header "Content-Type: application/json" --data-binary "{\"type\": \"file\", \"title\": \"StataPush\", \"body\": \"`message'\", \"file_name\": \"`attach'\", \"file_type\": \"`file_type'\", \"file_url\": \"`file_url'\"}" --request POST https://api.pushbullet.com/v2/pushes
        }
    }
	display as text "Notification pushed at `c(current_time)' via Pushbullet"
end

* Upload a file with Pushbullet
capture program drop _uploadpushbullet
program define _uploadpushbullet, rclass
    version 12.1
    syntax, Token(string) Attach(string)

    * Confirm file
    quietly capture confirm file "`attach'"
    if _rc != 0 {
        display as error "File not found: `attach'."
        exit 601
    }

    * Get file extension
    local next "`attach'"
    gettoken extension next: next, parse(".")
    while (`"`next'"' != "") {
        gettoken extension next: next, parse(".")
    }

    * Set file type
    if inlist("`extension'", "png", "wmf", "jpeg", "jpg") {
        local file_type "image/`extension'"
    }
    else if inlist("`extension'", "eps", "ps") {
        local file_type "application/postscript"
    }
    else if inlist("`extension'", "pdf") {
        local file_type "application/pdf"
    }
    else if inlist("`extension'", "log", "txt") {
        local file_type "text/plain"
    }
    else {
        local file_type "application/octet-stream"
    }

    * Request URL from Pushbullet and save response to temporary file
    tempfile responsetxt
    quietly !curl --header "Access-Token: `token'" --header "Content-Type: application/json" --data-binary "{\"file_name\": \"`attach'\", \"file_type\": \"`file_type'\"}" --request POST https://api.pushbullet.com/v2/upload-request >> "`responsetxt'"
 
    * Read JSON response and extract URL info
    file open jsonfile using `responsetxt', read text
    file read jsonfile line
    quietly display regexm(`"`macval(line)'"', "file_url.+,")
    local file_url = substr(regexs(0), 12, length(regexs(0)) - 13)
    quietly display regexm(`"`macval(line)'"', "upload_url.+}")
    local upload_url = substr(regexs(0), 14, length(regexs(0)) - 15)
    file close jsonfile

    * Upload file
    quietly !curl -i -X POST `upload_url' -F "file=@`attach'"

    return local file_url "`file_url'"
    return local upload_url "`upload_url'"
    return local file_type "`file_type'"
end

* Pull StataPush preferences
capture program drop _statapushprefgrab
program define _statapushprefgrab, rclass
    quietly findfile statapushconfig.ado
    quietly include "`r(fn)'"
    return local provider "`default_provider'"
    return local token    "``default_provider'_token'"
    return local userid   "``default_provider'_userid'"
end

