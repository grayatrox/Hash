#include crypto.ahk

Username := "User"
Password := "Password"
newPassword := "P@ssw0rd"

pwHash := setPassword(Username,Password)
SendToServer := "Login:|USER=" UserName "&HASH=" pwHash ; login string
; SendToServer := "Login:|USER=User&HASH=574C427E4FFB38FB" ; login string

newPwHash := setPassword(Username,newPassword)
SendToServer := "CHAPWD:|USER=" UserName "&HASH=" pwHash "&NEWHASH=" newPwHash
; SendToServer := "CHAPWD:|USER=User&HASH=574C427E4FFB38FB&NEWHASH=4D4A5534A825529C"

setPassword(username,pwd){
	global k0,k1,k2,k3, l0,l1, m0,m1
	pwString := username pwd
	Return %  XCBC(Hex(pwString,StrLen(pwString)), 0,0, k0,k1,k2,k3, l0,l1, m0,m1)
}
