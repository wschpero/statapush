# statapush
statapush is a simple Stata module for sending push notifications. It is designed to be used when you have an analysis that will take a long time to process; the module will let you know your code has finished running (or if an error is produced) via an alert on your mobile device. It was inspired by the R package [pushoverr](https://github.com/briandconnelly/pushoverr).

###Prerequisites

1. **Stata**: statapush should be compatible with Stata v12.1+. While it may be compatible with earlier versions, it has not been tested in those environments.
2. **cURL**:  statapush requires [cURL](https://curl.haxx.se/download.html), an open source command line tool and library. cURL is installed by default on most computers using Mac OS and Unix, but likely requires manual installation for Windows.
3. **Pushbullet** or **Pushover**:  statapush requires users to sign up for a free [Pushbullet](https://www.pushbullet.com) or [Pushover](https://pushover.net) account. 

#####For Pusbullet:
1. Create a free [Pushbullet](http://pushbullet.com/) account.
2. Create an API token under [account settings](https://www.pushbullet.com/#settings/account) by clicking "Create Access Token."
3. Install the Pushbullet [client](https://www.pushbullet.com/apps) on your device (Android, iOS, or Desktop).

#####For Pushover:
1. Create a free [Pushover](https://pushover.net) account.
2. Register a new Pushover [application](https://pushover.net/apps/build). Choose any name for the application (e.g., "statapush") and select "Application" under the "Type" dropdown.
3. Install the Pushover [client](https://pushover.net/clients) on your device (Android, iOS, or Desktop).

###Installation Options

**SSC Archive**: Run the code below via the Stata command line.
	
	ssc install statapush, replace

**Github (for Stata v13.1+)**: Run the code below via the Stata command line.

	net install statapush, from(https://raw.github.com/wschpero/statapush/master/) replace

**Github (for Stata v12.1+)**: [Download](https://github.com/wschpero/statapush/archive/master.zip) the files above. Run the code below via the Stata command line, inserting the directory where you saved the files.

	net install statapush, from(<LOCAL PATH TO FILES>) replace

###Using statapush

statapush is pretty easy to use. Just place the snippet below (with your API token, user key, and message) at the point you want Stata to generate the push notification in your do file.

	statapush, token(<INSERT API TOKEN>) userid(<INSERT USER KEY>) message(<INSERT MESSAGE>)

If you would like to use Pushbullet instead of Pushover, simply add the optional "provider(pushbullet)" argument.

    statapush, token(<INSERT API TOKEN>) userid(<INSERT USER KEY>) message(<INSERT MESSAGE>) provider(pushbullet)

If you would like statapush to notify you when your code has finished running *and* if an error is detected, run your code from the statapush command by specifying your do file with the syntax below.

    statapush using <INSERT FILENAME>, token(<INSERT TOKEN>) userid(<INSERT USER KEY>) message(<INSERT MESSAGE>)

Lastly, you can set your default preferences so you do not need to include your API token and user key every time you run the command. Your preferences are saved in a file called statapushconfig.ado along with your other Stata packages. Be sure to specify either "pushbullet" or "pushover" in the the "provider()" argument.

    statapushpref, token(<INSERT API TOKEN>) userid(<INSERT USER KEY>) provider(<INSERT PROVIDER>)
    statapush, message(<INSERT MESSAGE>)

###Bug Reports

Please [let me know](https://github.com/wschpero/statapush/issues) if you encounter any issues. Enjoy!

###Disclaimers

This Stata module and its author are not affiliated with [Pushbullet](http://pushbullet.com/) or [Pushover](https://pushover.net).
