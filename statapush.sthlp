{smcl}
{* 10feb2016}
{title: Title}

{p 4 8}{cmd:statapush} - Stata module for sending push notifications

{title: Syntax}

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:string}) {cmdab:u:serid}({it:string}) {cmdab:m:essage}({it:string})

{title: Description}

{p 4 8}{cmd:statapush} is compatible with Stata v12.1+. While it may be compatible with earlier versions, it has not been tested in those environments.

{p 4 8}{cmd:statapush} requires cURL, an open source command line tool and library. cURL is installed by default on computers using Mac OS and Unix, but requires {browse "https://curl.haxx.se/download.html":manual installation} for Windows.

{p 4 8}{cmd:statapush} also requires use of the push notification service Pushover.

{p 4 8}{bf:1.} Create a free {browse "https://pushover.net":Pushover} account and make note of your user key.

{p 4 8}{bf:2.} Register a new Pushover application. Choose any name for the application (e.g., StataPush) and select "Application" under the "Type" dropdown. Make note of the API token associated with this application.

{p 4 8}{bf:3.} Install the Pushover {browse "https://pushover.net/clients":client} on your device (Android, iOS, or Desktop). The client is available for a free seven-day trial, after which users must pay a one-time $4.99 fee per device.

{title: Options}

{p 4 8}{bf:Note:} All three arguments below are required.

{p 4 8}{cmdab:t:oken}({it:string}) Use this option to provide your Pushover API token.

{p 4 8}{cmdab:u:serid}({it:string}) Use this option to provide your Pushover user key.

{p 4 8}{cmdab:m:essage}({it:string}) Use this option to specify the message you would like included in your push notification.

{title: Examples}

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) 

{title: Author}

{p 4 4}William L. Schpero{break}
{browse "mailto:william.schpero@yale.edu":william.schpero@yale.edu}{break}
