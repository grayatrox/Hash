#include crypto.ahk

; Sorry if this is confusing. (it makes perfect sense to me)
; I haven't done any username reserving here.


; Login event sent from client
data := "Login:|USER=User&HASH=574C427E4FFB38FB" ; username and hashed password
/*
   code sperating data
*/
; sperated data
action := "login"
this_user := "User"
this_usrhash := "574C427E4FFB38FB"
/*
	code to find and retrieve stored username and hash
*/
;Stored Hash and username
USRHASH := "574C427E4FFB38FB"
USRNME := "User"

; process the login event
if (action == "login" && !loggedIn) {
	if (this_user == USRNME && this_usrhash == USRHASH) {
		loggedIn := true
		SendToClient("Login Granted")
		;Return ; We have finished processing this request, we can now wait for another.
	} else {
		SendToClient("Login Denied - Invalid Username/Password Combination")
		;Return
	}
} else {
	SendToClient("Already Loggedin")
	;Return
}
; change password event
data := "CHAPWD:|USER=User&HASH=574C427E4FFB38FB&NEWHASH=4D4A5534A825529C" ; username, current hashed password, new hashed password
/*
   code sperating data
*/

; sperated data
action := "changePassword"
this_user := "User"
this_usrhash := "574C427E4FFB38FB"
this_newuserhash := "4D4A5534A825529C"
/*
	code to find and retrieve stored username and hash
*/
;Stored Hash and username
USRHASH := "574C427E4FFB38FB"
USRNME := "User"

;process the change password event
if (loggedIn) { ; actions that require the user to be logged in
	if (action == "changePassword" && this_user == USRNME && this_usrhash == USRHASH) { ; we check the original hash again just to be 
																						; sure it really is the user trying to login
		USRHASH := this_newuserhash
		SendToClient("Password Change Successful")
		;store the new USRHASH with username
		;Return
	} else {
		SendToClient("Password Change Denied - Invalid Username/Password Combination")
		;Return
	}
} else {
	SendToClient("Please Login First")
	;Return
}
Return
	
SendToClient(msg) {
	msgbox %msg%
}