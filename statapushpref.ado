capture program drop statapushpref
program define statapushpref
    version 12.1
    syntax, Provider(string) Token(string) Userid(string)
    findfile statapushpref.ado
    file open statapushpref_ado using "`r(fn)'", write append
    file write statapushpref_ado "local default_provider `provider'" _n
    file write statapushpref_ado "local `provider'_token `token'"    _n
    file write statapushpref_ado "local `provider'_userid `userid'"  _n
    file close statapushpref_ado
end