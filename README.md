# statapush
statapush is a simple Stata module for sending push notifications. It is designed to be used when you have an analysis that will take a long time to process; the module will let you know your code has finished running via an alert on your mobile device. statapush relies on the push notification service [Pushover](https://pushover.net) or [Pushbullet](https://www.pushbullet.com). It was inspired by the R package [pushoverr](https://github.com/briandconnelly/pushoverr). 

###Prerequisites

1. **Stata**: statapush should be compatible with Stata v12.1+. While it may be compatible with earlier versions, it has not been tested in those environments.
2. **cURL**:  statapush requires [cURL](https haxx.se/download.html), an open source command line tool and library. cURL is installed by default on most computers using Mac OS and Unix, but likely requires manual installation by Windows OS users.
3. **Pushover** or **Pushbullet**:  statapush requires users to sign up for a free [Pushover](https://pushover.net) account or [Pushbullet](https://www.pushbullet.com) account. For Pushover, upon creating an account, make note of your user key and register a new application. Choose any name for the application (e.g., StataPush) and select “Application” under the “Type” dropdown. Make note of the API token associated with this application. You will also need to install the Pushover [client](https://pushover.net/clients) on your device (Android, iOS, or Desktop). The client is available for a free seven-day trial, after which users must pay a one-time $4.99 fee per device. For Pushbullet, upon creating an account, you can create an API token under [account settings](https://www.pushbullet.com/#settings/account) by clicking "Create Access Token." You'll use this token and your username with statapush. The [Pushbullet clients](https://www.pushbullet.com/apps) are free to use for notification mirroring. 

###Installation Options

**SSC Archive**: Run the code below via the Stata command line.
	
	ssc install statapush, replace

**Github (for Stata v13.1+)**: Run the code below via the Stata command line.

	net install statapush, from(https://raw.github.com/wschpero/statapush/master/) replace

**Github (for Stata v12.1+)**: [Download](https://github.com/wschpero/statapush/archive/master.zip) the files above. Run the code below via the Stata command line, inserting the directory where you saved the files.

	net install statapush, from(<LOCAL PATH TO FILES>) replace

###Using statapush

statapush is pretty simple to use. Just place the snippet below (with your API token, user key, and message) at the point you want Stata to generate the push notification in your do file. Then run the file.

	statapush, token(<TOKEN>) userid(<USER KEY>) message(<MESSAGE>)

If you'd like to use Pushbullet, simply add the option

    statapush, token(<TOKEN>) userid(<USER KEY>) message(<MESSAGE>) provider("pushbullet")

statapush can also run a do file by optionally including a do file. Doing so will enable you to receive a notification when you do file completes.

    statapush using "<FILENAME>", token(<TOKEN>) userid(<USER KEY>) message(<MESSAGE>)

You can also set your default preferences so you don't need to include your API token and user ID every time.

    statapushpref, provider("pushover") userid(<USER KEY>) token(<TOKEN>)

You preferences are saved in a file called statapushpref.do along with your other Stata packages.

###Bug Reports

Please [let me know](https://github.com/wschpero/statapush/issues) if you encounter any issues. Enjoy!

###Disclaimers

This Stata module and its author are not affiliated with [Pushover](https://pushover.net).
