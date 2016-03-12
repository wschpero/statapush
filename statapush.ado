/*
statapush: Stata module for sending push notifications
Authors: William L. Schpero and Vikram Jambulapati
Contact: william.schpero@yale.edu
Date: 022016
Version: 2.0
*/

capture program drop statapush
program define statapush
    version 12.1
    syntax [using/], Message(string) [Token(string) Userid(string)] [Provider(string)] [Attach(string)]

    * Load default preferences if token/userid not given
    if "`token'" == "" {
        _statapushprefgrab
        local token    "`r(token)'"
        local userid   "`r(userid)'"
        local provider "`r(provider)'"
    }

    * Check whether attach specified correctly
    if "`attach'" != "" & "`provider'" != "pushbullet" {
        display as error "Only 'pushbullet' supports 'attach'"
        exit 198
    }

    * Pick pushcmd based on provider
    if "`provider'" == "" | lower("`provider'") == "pushover" {
        local pushcmd "_statapush"
    }
    else if lower("`provider'") == "pushbullet" {
        local pushcmd "_statapushbullet"
    }
    else {
        display as error "Invalid provider: `provider'. Need to use 'pushover' or 'pushbullet'."
        exit 198
    }

    * Run the do file if "using" specified, otherwise just push message
    if "`using'" != "" {
        capture noisily do "`using'"
        if _rc == 0 {
            `pushcmd', t(`token') u(`userid') m(`message') a(`attach')
        }
        else {
            `pushcmd', t(`token') u(`userid') m("There's an error in `using'.")
        }
    }
    else {
        `pushcmd', t(`token') u(`userid') m(`message') a(`attach')
    }

end

* Pushover command
capture program drop _statapush
program define _statapush
    version 12.1
    syntax, Token(string) Userid(string) Message(string) [Attach(string)]
    quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=statapush" -F "message=`message'" https://api.pushover.net/1/messages.json
    display as text "Notification pushed at `c(current_time)'"
end

* Pushbullet command
capture program drop _statapushbullet
program define _statapushbullet
    version 12.1
    syntax, Token(string) Message(string) [Userid(string)] [Attach(string)]
    if "`attach'" == "" {
        quietly !curl -u "`token'": -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "statapush", "body": "`message'"}'
    }
    else {
        _uploadpushbullet, t("`token'") a("`attach'")
        local file_url "`r(file_url)'"
        local upload_url "`r(upload_url)'"
        quietly !curl --header 'Access-Token: `token'' --header 'Content-Type: application/json' --data-binary '{"type": "file", "title": "statapush", "body": "`message'", "file_name":"`attach'", "file_type":"image/png", "file_url":"`file_url'"}' --request POST https://api.pushbullet.com/v2/pushes
    }
	display as text "Notification pushed at `c(current_time)'"
end

* Upload a file with Pushbullet
capture program drop _uploadpushbullet
program define _uploadpushbullet, rclass
    version 12.1
    syntax, Token(string) Attach(string)
    * Request URL from Pushbullet and save response to temporary file
    tempfile responsetxt
    quietly !curl --header 'Access-Token: `token'' --header 'Content-Type: application/json' --data-binary '{"file_name": "`attach'", "file_type": "image/png"}' --request POST https://api.pushbullet.com/v2/upload-request >> "`responsetxt'"
 
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

    return local file_url "`upload_url'"
    return local upload_url "`file_url'"
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

