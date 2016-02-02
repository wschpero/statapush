{smcl}
{* 01feb2016}
{hline}
help for {hi:statapush}
{hline}

{title: Stata module for sending push notifications from the command line}

{title:Syntax}

{p 4}{cmd:statapush}, 
{cmdab:t:oken}({it:string})
{cmdab:u:serid}({it:string})
{cmdab:m:essage}({it:string})

{title: Description}

{p 4 8}{cmd:statapush} is compatible with Stata v 12.1+. While it likely is compatible with earlier versions, it has not been tested in those environments.

{p 4 8}{cmd:statapush} requires cURL, an open source command line tool and library. cURL is installed by default on most computers using Mac OS, but likely requires manual installation by Windows OS users. cURL may be downloaded by going to https://curl.haxx.se/download.html.

{p 4 8}{cmd:statapush} also requires users to sign up for a free Pushover account at https://pushover.net. Upon creating an account, make note of your user key and register a new application. Choose any name for the application (e.g., StataPush) and select “Application” under the “Type” dropdown. Make note of the API token associated with this application. You will also need to install the Pushover client on your device (Android, iOS, or Desktop). The client is available for a free seven-day trial, after which users must pay a one-time $4.99 fee per device.

{title: Options}

{p 4 4}{cmdab:t:oken}({it:string}) Use this option to provide your Pushover API token.

{p 4 4}{cmdab:u:serid}({it:string}) Use this option to provide your Pushover user key.

{p 4 4}{cmdab:m:essage}({it:string}) Use this option to specify the message you would like included in your push notification.

{title: Examples}

{p 4 4}{cmd:statapush}, {cmdab:t:oken}({it:aRyeC6J5Qk81MtWxxxxxxxxxxxxxxxx}) {cmdab:u:serid}({it:uKMk6zAoMZHX9Xpxxxxxxxxxxxxxxx}) {cmdab:m:essage}({it:”Do File Complete.“}) 

{title:Author}

{p 4 4}William L. Schpero{break}
william.schpero@yale.edu{break}
