{smcl}
{* 05june2016}
{title: Title}

{p 4 8}{cmd:statapush} - Stata module for sending push notifications

{title: Syntax}

{p 4 8}{cmd:statapush} [{cmd:using} {it:{help filename}}], {cmdab:t:oken}({it:string}) {cmdab:u:serid}({it:string}) {cmdab:m:essage}({it:string}) [{cmdab:a:ttachment}({it:string})] [{cmdab:p:rovider}({it:string})]

{title: Description}

{p 4 8}{cmd:statapush} is compatible with Stata v12.1+. While it may be compatible with earlier versions, it has not been tested in those environments.

{p 4 8}{cmd:statapush} requires cURL, an open source command line tool and library. cURL is installed by default on computers using Mac OS and Unix, but requires {browse "https://curl.haxx.se/download.html":manual installation} for Windows.

{p 4 8}{cmd:statapush} also requires use of the free push notification service {browse "http://pushbullet.com/":Pushbullet}, {browse "https://pushover.net":Pushover} or {browse "https://ifttt.com/":IFTTT}.

{p 4 8}{bf:For Pushbullet}

{p 4 8}{bf:1.} Create a free {browse "http://pushbullet.com/":Pushbullet} account.

{p 4 8}{bf:2.} Create an API token under {browse "https://www.pushbullet.com/#settings/account":account settings} by clicking "Create Access Token."

{p 4 8}{bf:3.} Install the Pushbullet {browse "https://www.pushbullet.com/apps":client} on your device (Android, iOS, or Desktop).

{p 4 8}{bf:For Pushover}

{p 4 8}{bf:1.} Create a free {browse "https://pushover.net":Pushover} account.

{p 4 8}{bf:2.} Register a new Pushover application. Choose any name for the application (e.g., StataPush) and select "Application" under the "Type" dropdown.

{p 4 8}{bf:3.} Install the Pushover {browse "https://pushover.net/clients":client} on your device (Android, iOS, or Desktop).

{p 4 8}{bf:For IFTTT}

{p 4 8}{bf:1.} Create a free {browse "https://ifttt.com/join":IFTTT} account.

{p 4 8}{bf:2.} Set up an IFTTT {browse "https://ifttt.com/maker":Maker} Channel.

{p 4 8}{bf:3.} Add the StataPush {browse "https://ifttt.com/recipes/396911-statapush-to-sms":SMS}, {browse "https://ifttt.com/recipes/396816-statapush-to-email":email} or {browse "https://ifttt.com/recipes/396919-statapush-to-if-notification":IF} recipe depending on which type of notification you would like to use. Be sure the recipe event name is "StataPush".


{title: Options}

{p 4 8}{bf:Note:} All three arguments below are required.

{p 4 8}{cmdab:t:oken}({it:string}) Use this option to provide your Pushbullet, Pushover, or IFTTT token.

{p 4 8}{cmdab:u:serid}({it:string}) Use this option to provide your Pushbullet username (email address), Pushover user key, or IFTTT username (email address).

{p 4 8}{cmdab:m:essage}({it:string}) Use this option to specify the message you would like included in your push notification.

{p 4 8}{bf:Note:} The following arguments are not required.

{p 4 8}{cmdab:a:ttachment}({it:string}) Use this option to specify the file path for the attachment you would like included with your notification. This option is only compatible with Pushbullet.

{p 4 8}{cmdab:p:rovider}({it:string}) Use this option to specify the push notification service you would like to use (Pushbullet, Pushover, or IFTTT). By default, Pushover is used. Specify "pushbullet" to use Pushbullet and "ifttt" to use IFTTT.

{title: Examples}

{p 4 8}statapush is pretty easy to use. Just place the snippet below (with your token, user key, and message) at the point you want Stata to generate the push notification in your do file. Then run the file.

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) 

{p 4 8}If you would like to use Pushbullet instead of Pushover, simply add the optional "provider(pushbullet)" argument.

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) {cmdab:p:rovider}({it:pushbullet})

{p 4 8}To use IFTTT, instead add the optional "provider(ifttt)" argument.

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) {cmdab:p:rovider}({it:ifttt})

{p 4 8}If you would like statapush to notify you when your code has finished running {it:and} if an error is detected, run your code from the statapush command by specifying your do file with the syntax below.

{p 4 8}{cmd:statapush} {cmd:using} {it:{help filename}}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) 

{p 4 8}If you're using Pushbullet, you can attach a file (e.g., output graph) that you'll receive with your notification.

{p 4 8}{cmd:statapush}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:m:essage}({it:<INSERT MESSAGE>}) {cmdab:a:ttachment}({it:<INSERT FILE PATH>})

{p 4 8}Lastly, you can set your default preferences so you do not need to include your token, user key, and push notification service preferences every time you run the command.

{p 4 8}{cmd:statapushpref}, {cmdab:t:oken}({it:<INSERT API TOKEN>}) {cmdab:u:serid}({it:<INSERT USER KEY>}) {cmdab:p:rovider}({it:<INSERT PROVIDER>}) 

{p 4 8}{cmd:statapush}, {cmdab:m:essage}({it:<INSERT MESSAGE>}) 

{title: Authors}

{p 4 4}William L. Schpero and Vikram Jambulapati

{title: Contact}

{p 4 4}{browse "mailto:william.schpero@yale.edu":william.schpero@yale.edu}{break}
