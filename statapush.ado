/*

statapush: Stata module for sending push notifications

Author: William L. Schpero
Contact: william.schpero@yale.edu
Date: 020216
Version: 1.1

*/

program statapush

	version 12.1
	
	syntax , Token(string) Userid(string) Message(string)
	quietly !curl -s -F "token=`token'" -F "user=`userid'" -F "title=StataPush" -F "message=`message'" https://api.pushover.net/1/messages.json
	display "Notification pushed at `c(current_time)'"

end
