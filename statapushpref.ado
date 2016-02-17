capture program drop statapushpref
program define statapushpref
    version 12.1
    syntax, Provider(string) Token(string) Userid(string)
    quietly findfile statapushconfig.ado
    quietly file open statapushpref_ado using "`r(fn)'", write append
    quietly file write statapushpref_ado "local default_provider `provider'" _n
    quietly file write statapushpref_ado "local `provider'_token `token'"    _n
    quietly file write statapushpref_ado "local `provider'_userid `userid'"  _n
    quietly file close statapushpref_ado
    if _rc == 0 {
        findfile statapushconfig.ado
        display "Your preferences have been saved in `r(fn)'"
    }
end