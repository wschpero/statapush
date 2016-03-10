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
    syntax [using/], Message(string) [Token(string) Userid(string)] [Provider(string)]

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
    else {
        display as error "Invalid provider: `provider'. Need to use 'pushover' or 'pushbullet'."
        exit 198
    }

    * Run the do file if "using" specified
    if "`using'" != "" {
        capture noisily do "`using'"
        if _rc == 0 {
            `pushcmd', t(`token') u(`userid') m(`message')
        }
        else {
            `pushcmd', t(`token') u(`userid') m("There's an error in `using'.")
        }
    }
    else {
        `pushcmd', t(`token') u(`userid') m(`message')
    }

end

* Pushover command
capture program drop _statapush
program define _statapush
    version 12.1
    syntax, Token(string) Userid(string) Message(string)
    quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=statapush" -F "message=`message'" https://api.pushover.net/1/messages.json
    display as text "Notification pushed at `c(current_time)'"
end

* Pushbullet command
capture program drop _statapushbullet
program define _statapushbullet
    version 12.1
    syntax, Token(string) Message(string) [Userid(string)]
    quietly !curl -u "`token'": -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "statapush", "body": "`message'"}'
	display as text "Notification pushed at `c(current_time)'"
end

* Upload a file with Pushbullet
capture program drop _uploadpushbullet
program define _uploadpushbullet
    version 12.1
    syntax, Token(string) File(string)
    tempfile responsetxt
    !curl --header 'Access-Token: `token'' --header 'Content-Type: application/json' --data-binary '{"file_name": "`file'", "file_type": "image/png"}' --request POST https://api.pushbullet.com/v2/upload-request >> "`responsetxt'"
    file open jsonfile using `responsetxt', read text
    file read jsonfile line
    quietly display regexm(`"`macval(line)'"', "file_url.+,")
    local file_url = substr(regexs(0), 12, length(regexs(0)) - 13)
    quietly display regexm(`"`macval(line)'"', "upload_url.+}")
    local upload_url = substr(regexs(0), 14, length(regexs(0)) - 15)
    file close jsonfile
    quietly !curl --header 'Access-Token: `token'' --header 'Content-Type: application/json' --data-binary '{"type": "file", "title": "statapush", "body": "`message'", "file_name":"`file'", "file_type":"image/png", "file_url":"`file_url'"}' --request POST https://api.pushbullet.com/v2/pushes
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

