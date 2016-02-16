
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
    syntax [using/], Token(string) Userid(string) Message(string)

    if "`using'" != "" {
        capture noisily do "`using'"
        if _rc == 0 {
            _statapush, t(`token') u(`userid') m(`message')
        }
        else {
            _statapush, t(`token') u(`userid') m("There's an error in `using'.")
        }
    }
    else {
        _statapush, t(`token') u(`userid') m(`message')
    }

end

capture program drop _statapush
program define _statapush
    version 12.1
    syntax [using/], Token(string) Userid(string) Message(string)
    quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=statapush" -F "message=`message'" https://api.pushover.net/1/messages.json
    display "Notification pushed at `c(current_time)'"
end

/*
 
*/
