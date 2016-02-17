
/*
statapush: Stata module for sending push notifications
Author: William L. Schpero
Contact: william.schpero@yale.edu
Date: 020216
Version: 1.1
*/

capture program drop statapush
program define statapush
    version 12.1
    syntax [using/], Message(string) [Token(string) Userid(string)] [Provider(string)]

    * Load default preferences if token/userid not given
    if "`token'" == "" {
        _statapushprefgrab
        local token "`r(token)'"
        local userid "`r(userid)'"
        local provider "`r(provider)'"
    }

    if "`provider'" == "" | "`provider'" == "pushover" {
        local pushcmd "_statapush"
    }
    else if "`provider'" == "pushbullet" {
        local pushcmd "_statapushbullet"
    }

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

capture program drop _statapush
program define _statapush
    version 12.1
    syntax [using/], Token(string) Userid(string) Message(string)
    quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=statapush" -F "message=`message'" https://api.pushover.net/1/messages.json
    display "Notification pushed at `c(current_time)'"
end

capture program drop _statapushbullet
program define _statapushbullet
    version 12.1
    syntax [using/], Token(string) Message(string) [Userid(string)]
    quietly !curl https://api.pushbullet.com/v2/pushes -X POST -u "`token'": --header "Content-Type: application/json" --data-binary "{\"type\": \"note\", \"title\":\"StataPush\", \"body\": \"`message'\"}"
    display "Notification pushed at `c(current_time)'"
end

capture program drop _statapushprefgrab
program define _statapushprefgrab, rclass
    findfile statapushconfig.ado
    quietly include "`r(fn)'"
    return local provider "`default_provider'"
    return local token    "``default_provider'_token'"
    return local userid  "``default_provider'_userid'"
end

