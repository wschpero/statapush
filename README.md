# statapush
statapush is a simple Stata module for generating push notifications from the Stata command line. It is heavily inspired by the R package [pushoverr](https://github.com/briandconnelly/pushoverr).

When you have an analysis that will take some time to complete, you can use statapush to let you know your code has finished running via an alert on your mobile device. statapush relies on the push notification service [Pushover](https://pushover.net).

###Prerequisites

1. **Stata**: statapush is compatible with Stata v 13.1. While it likely is compatible with earlier versions, it has not been tested in those environments.
2. **cURL**:  statapush requires [cURL](https haxx.se/download.html), an open source command line tool and library. cURL is installed by default on most computers using Mac OS, but likely requires manual installation by Windows OS users.
3. **Pushover**:  statapush requires users to sign up for a free [Pushover](https://pushover.net) account. Upon creating an account, make note of your user key and register a new application. Choose any name for the application (e.g., StataPush) and select “Application” under the “Type” dropdown. Make note of the API token associated with this application. You will also need to install the Pushover client on your device (Android, iOS, or Desktop). The client is available for a free seven-day trial, after which users must pay a one-time $4.99 fee per device.

###Installation

Stata net install isn't working for me at the moment. For now, please install statapush manually.
	
###Using statapush

statapush is pretty simple to use. Just place the snippet below (with your API token, user key, and message) at the point you want Stata to generate the push notification in your do file. Then run the file

	statapush, token(<TOKEN>) userid(<USER KEY>) message(<MESSAGE>)

###Bug Reports

Please [let me know](https://github.com/wschpero/statapush/issues) if you encounter any issues. Enjoy!

