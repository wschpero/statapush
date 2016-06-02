/*
statapushpref: Stata module to save preferences for statapush
Authors: William L. Schpero and Vikram Jambulapati
Contact: william.schpero@yale.edu
Date: 022016
Version: 1.0
*/

capture program drop statapushpref
program define statapushpref
    version 12.1
    syntax, Token(string) Userid(string) Provider(string)
    local provider = lower("`provider'")
    quietly findfile statapushconfig.ado
    local statapushconfig "`r(fn)'"
    quietly file open statapushpref_ado using "`statapushconfig'", write append
    quietly file write statapushpref_ado "local default_provider `provider'" _n
    quietly file write statapushpref_ado "local `provider'_token `token'"    _n
    quietly file write statapushpref_ado "local `provider'_userid `userid'"  _n
    quietly file close statapushpref_ado
    if _rc == 0 {
        display as result "Your preferences have been saved in statapushconfig.ado."
    }
end
