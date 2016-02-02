/*

Title: StataPush
Description: Stata module for sending push notifications

Author: William Schpero
Institution: Yale University
Contact: william.schpero@yale.edu
Date: February 2016
Version: 0.5

*/

program statapush

	version 13
	
	syntax [, Token(string) Userid(string) Message(string)]
	!curl -s -F "token=`token'" -F "user=`userid'" -F "title=StataPush Notification" -F "message=`message'" https://api.pushover.net/1/messages.json

end
