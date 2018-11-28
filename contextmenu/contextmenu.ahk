#SingleInstance Force
Gui, Tab, 1
Gui, Add, Tab3, buttons, ADD|DEL
if (a_isadmin){
	Gui, Add, Checkbox, vALL, All users
} else {
	Gui, Add, Checkbox, vALL Disabled, All users
}
Gui, Add, Checkbox, vEXT, Extended

Gui, Add, Text,, Type (!):
Gui, Add, Edit, vTYP
Gui, Add, Text,, Name (!):
Gui, Add, Edit, vLOC
Gui, Add, Text,, Display (!):
Gui, Add, Edit, vDIS
Gui, Add, Text,, Command (!):
Gui, Add, Edit, vCMD
Gui, Add, Text,, Icon:
Gui, Add, Edit, vICO
Gui, Add, Button, default, ADD

Gui, Tab, 2
if (a_isadmin){
	Gui, Add, Checkbox, vDALL, All users
} else {
	Gui, Add, Checkbox, vDALL Disabled, All users
}
Gui, Add, Checkbox, vDEXT, Extended

Gui, Add, Text,, Type (!):
Gui, Add, Edit, vDTYP
Gui, Add, Text,, Name (!):
Gui, Add, Edit, vDLOC

Gui, Add, Button, default, DEL

Gui, Show,, Add/Delete context menu item
return

ButtonADD:
Gui, Submit
if %ALL%
	pre:=""
else
	pre:="""pre=HKCU\Software\Classes"" "

if (TYP=="") OR (LOC=="") OR  (DIS=="") OR (CMD=="")
	MsgBox Error: Missing required variable(s)
else
	;MsgBox contextmenu %pre%add "%TYP%" "%LOC%" "%DIS%" "%CMD%" %EXT% "%ICO%"
	RunWait, cmd.exe /c contextmenu %pre%add %TYP% %LOC% %DIS% %CMD% %EXT% %ICO%
ExitApp

ButtonDEL:
Gui, Submit
if %DALL%
	pre:=""
else
	pre:="""pre=HKCU\Software\Classes"" "

if (DTYP=="") OR (DLOC=="")
	MsgBox Error: Missing required variable(s)
else
	;MsgBox contextmenu %pre%del %DTYP% %DLOC%
	RunWait, cmd.exe /c contextmenu %pre%del %DTYP% %DLOC%
ExitApp

GuiClose:
GuiEscape:
ExitApp
