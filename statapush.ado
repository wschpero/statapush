/*

statapush: Stata module for sending push notifications

Author: William L. Schpero
Contact: william.schpero@yale.edu
Date: 020116
Version: 1.0

*/

program statapush

	version 13
	
	syntax [, Token(string) Userid(string) Message(string)]
	!curl -s -F "token=`token'" -F "user=`userid'" -F "title=StataPush Notification" -F "message=`message'" https://api.pushover.net/1/messages.json

end
