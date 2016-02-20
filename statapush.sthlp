{smcl}
{* 10feb2016}
{title: Title}

{p 4 8}{cmd:statapush} - Stata module for sending push notifications

{title: Syntax}

{p 4 8}{cmd:statapush} [{cmd:using} {it:{help filename}}], {cmdab:t:oken}({it:string}) {cmdab:u:serid}({it:string}) {cmdab:m:essage}({it:string}) [{cmdab:p:rovider}({it:string})]

{pstd}
You may optionally include a do file to run in {it:filename}. Doing so will enable you to still get a notification if you code contains an error. You may enclose {it:filename} in double quotes and must do so if
{it:filename} contains blanks or other special characters.

{title: Description}

{p 4 8}{cmd:statapush} is compatible with Stata v12.1+. While it may be compatible with earlier versions, it has not been tested in those environments.

{p 4 8}{cmd:statapush} requires cURL, an open source command line tool and library. cURL is installed by default on computers using Mac OS and Unix, but requires {browse "https://curl.haxx.se/download.html":manual installation} for Windows.

{p 4 8}{cmd:statapush} also requires use of the push notification service Pushover or Pushbullet.

{p 4 8}{bf:For Pushover}

{p 4 8}{bf:1.} Create a free {browse "https://pushover.net":Pushover} account and make note of your user key.

{p 4 8}{bf:2.} Register a new Pushover application. Choose any name for the application (e.g., StataPush) and select "Application" under the "Type" dropdown. Make note of the API token associated with this application.

{p 4 8}{bf:3.} Install the Pushover {browse "https://pushover.net/clients":client} on your device (Android, iOS, or Desktop). The Pushover client is available for a free seven-day trial, after which users must pay a one-time $4.99 fee per device.

{p 4 8}{bf:For Pushbullet}

{p 4 8}{bf:1.} Create a free {browse "http://pushbullet.com/":Pushbullet} account.

{p 4 8}{bf:2.} Create an API token under {browse "https://www.pushbullet.com/#settings/account":account settings} by clicking "Create Access Token."

{p 4 8}{bf:3.} Install the Pushbullet {browse "https://www.pushbullet.com/apps":client} on your device (Android, iOS, or Desktop). The Pushover client is available for free.

{title: Options}

{p 4 8}{bf:Note:} All three arguments below are required.

{p 4 8}{cmdab:t:oken}({it:string}) Use this option to provide your Pushover API token.

{p 4 8}{cmdab:u:serid}({it:string}) Use this option to provide your Pushover user key.

{p 4 8}{cmdab:m:essage}({it:string}) Use this option to specify the message you would like included in your push notification.

{p 4 8}{bf:Note:} The follow argument is not required.

{p 4 8}{cmdab:p:rovider}({it:string}) Use this option to specify the provider of the push notifications you'd like to use (Pushover or Pushbullet). By default, Pushover is used. Pass "pushbullet" to use Pushbullet.

{title: Examples}

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) 

{title: Author}

{p 4 4}William L. Schpero{break}
{browse "mailto:william.schpero@yale.edu":william.schpero@yale.edu}{break}
