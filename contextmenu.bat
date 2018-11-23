:: James C. Wise - 2018-11-22
:: Released under the "Don't Be A Dick" license

@echo off

:: contextmenu add [dir|lib] [name] [display] [cmd] [extended|] [icon|]
:: contextmenu del [dir|lib] [name]
:: contextmenu addf [ftype] [name] [display] [cmd] [extended|] [icon|]
:: contextmenu delf [ftype] [name]

::  <[name]>
::       |- (default)=[display]
::       |- extended="" ? [extended]==1
::       |- Icon?=[icon]
::       \- <command>
::                  |- (default)=[cmd]

if "%1"=="" goto :help
if "%1"=="/?" goto :help
goto :afterhelp
:help
	echo contextmenu add  [dir^|lib] [name] [display] [cmd] [extended^|] [icon^|]
	echo contextmenu addf [ext] [name] [display] [cmd] [extended^|] [icon^|]
	echo contextmenu del  [dir^|lib] [name]
	echo contextmenu delf [ext] [name]
	echo -----
	echo contextmenu add  : Add item to context menu
	echo     [dir^|lib]   : Add the item to regular directories or library directories
	echo     [name]       : Internal name of the context menu item
	echo     [display]    : The text displayed in the context menu
	echo     [cmd]        : The command you want the item to run. ^(use "cmd.exe /c [your command]" for batch commands^)
	echo     [extended^|] : If 1, the item will only be accessable via SHIFT+Right Click, otherwise it's just normal behaviour
	echo     [icon^|]     : The location of the icon for the item
	echo -----
	echo contextmenu addf : Add item to context menu for file type ^(very experimental^)
	echo     [ext]        : File extension, or "batfile" for .bat files
	echo     [the rest]   : See "contextmenu add"
	echo -----
	echo contextmenu del  : Remove item from context menu
	echo     [dir^|lib]   : Remove item from directory or library context menu?
	echo     [name]       : The internal name of the item to remove. ^(Not the display name^)
	echo -----
	echo contextmenu delf : Remove item from context menu
	echo     [ext]        : File extension to remove item from
	echo     [name]       : The internal name of the item to remove. ^(Not the display name^)
goto :EOF
:afterhelp

:: Delete item
if /i [%1]==[del] (
	if [%3]==[] echo Invalid Name & goto :EOF
	if /i [%2]==[dir] (
		reg delete HKCR\Directory\Background\shell\%3 /f
	) else (
		if /i [%2]==[lib] (
			reg delete HKCR\LibraryFolder\Background\shell\%3 /f
		) else (
			echo Invalid Type & goto :EOF
		)
	)
	goto :EOF
)
:: Add item
if /i [%1]==[add] (
	if /i [%2] NEQ [dir] (
		if /i [%2] NEQ [lib] echo Invalid Type & goto :EOF
	)
	:: Checking that paramaters 3-5 exist
	if [%3]==[] echo Invalid Name & goto :EOF
	if [%4]==[] echo Invalid Display & goto :EOF
	if [%5]==[] echo Invalid Command & goto :EOF
	:: Is the fifth argument [dir] or [lib]?
	if /i [%2]==[dir] (
		:: Add key+display name
		reg add HKCR\Directory\Background\shell\%3 /d %4 /f
		:: Add command
		reg add HKCR\Directory\Background\shell\%3\command /d %5 /f
		:: Add extended
		if [%6]==[1] reg add HKCR\Directory\Background\shell\%3 /v Extended /d [] /f
		:: Add icon
		if [%7] NEQ [] reg add HKCR\Directory\Background\shell\%3 /v Icon /d [] /f
		goto :EOF
	)
	if /i [%2]==[lib] (
		:: Add key+display name
		reg add HKCR\LibraryFolder\Background\shell\%3 /d %4 /f
		:: Add command
		reg add HKCR\LibraryFolder\Background\shell\%3\command /d %5 /f
		:: Add extended
		if [%6]==[1] reg add HKCR\LibraryFolder\Background\shell\%3 /v Extended /d [] /f
		:: Add icon
		if [%7] NEQ [] reg add HKCR\LibraryFolder\Background\shell\%2 /v Icon /d [] /f
		goto :EOF
	)
)

:: I tried to put this in the normal "add" command. Some bollocks with gettins a substring prevents that.
:: It was something like this:
:: set extension=%2
:: if %extension:~0,3%==ext (
::     set extension=%extension:~0:3%
:: )
::
:: Unfortunately, with %2=ext.png, sometimes it would give me "ext", and sometimes it would give me ".pn".
:: Then sometimes, if I tried "ext^.png", it would say something like "3==ext" was not expected at this time.
:: Honestly, I have no idea. I just figured it'd be better to not have to deal with that shit.
if /i [%1]==[addf] (
	:: Checking that paramaters 2-5 exist
	if [%2]==[] echo Invalid Format & goto :EOF
	if [%3]==[] echo Invalid Name & goto :EOF
	if [%4]==[] echo Invalid Display & goto :EOF
	if [%5]==[] echo Invalid Command & goto :EOF
	:: Add key+display name
	reg add HKCR\%2\shell\%3 /d %4 /f
	:: Add command
	reg add HKCR\%2\shell\%3\command /d %5 /f
	:: Add extended
	if [%6]==[1] reg add HKCR\%2\shell\%3 /v Extended /d [] /f
	:: Add icon
	if [%7] NEQ [] reg add HKCR\%2\shell\%3 /v Icon /d [] /f
	goto :EOF
)
if /i [%1]==[delf] (
	reg delete HKCR\%2\shell\%3 /f
)
:EOF