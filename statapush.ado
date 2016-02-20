
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
        display as error "Invalid provider: `provider'. Need to supply pushover or pushbullet."
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
    quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=StataPush" -F "message=`message'" https://api.pushover.net/1/messages.json
    display as text "Notification pushed at `c(current_time)'"
end

* Pushbullet command
capture program drop _statapushbullet
program define _statapushbullet
    version 12.1
    syntax, Token(string) Message(string) [Userid(string)]
    quietly !curl https://api.pushbullet.com/v2/pushes -X POST -u "`token'": --header "Content-Type: application/json" --data-binary "{\"type\": \"note\", \"title\":\"StataPush\", \"body\": \"`message'\"}"
    display as text "Notification pushed at `c(current_time)'"
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

