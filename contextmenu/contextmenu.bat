:: James C. Wise - 2018-11-22
:: Released under the "Don't Be A Dick" license

@echo off

:: contextmenu [pre|] add [dir|lib] [name] [display] [cmd] [extended|] [icon|]
:: contextmenu [pre|] del [dir|lib] [name]

::  <[name]>
::       |- (default)=[display]
::       |- extended="" ? [extended]==1
::       |- Icon?=[icon]
::       \- <command>
::                  |- (default)=[cmd]

:: <shenanigans volatility="high">
set pre=%1
if [%pre%]==[] goto :skipShift
if [%pre:~1,3%]==[pre] (
	set %pre%
	goto :doShift
) else (
	set pre=HKCR
	goto :skipShift
)
:doShift
shift
:skipShift
:: </shenanigans>

net session >nul 2>&1
if %errorlevel%==1 echo In its current state, this program requires you be an adminisitrator. Sorry! & goto :EOF
if "%1"=="" goto :help
if "%1"=="/?" goto :help
goto :afterhelp
:help
	echo.
	echo contextmenu add [pre^|] [filetype] [name] [display] [cmd] [extended^|] [icon^|]
	echo contextmenu del [pre^|] [filetype] [name]
	echo.
	echo.
	echo contextmenu add  : Add item to context menu
	echo     [pre^|]       : [Exasperated] "Oh boy, how do I explain this?"
	echo.
	echo                    /!\ WARNING /!\ : THIS FEATURE IS VERY EXPERIMENTAL. IT WILL LIKELY MESS SOMETHING UP IF USED IMPROPERLY
	echo.
	echo                    You can put "pre=[REGISTRY PATH]" (quotes included) as the first argument in order to apply changes to areas other than HKEY_CLASSES_ROOT
	echo                    To write to different root keys, use the following as the start of the registry path:
	echo                        HKLM = HKey_Local_machine
	echo                        HKCU = HKey_current_user
	echo                        HKU  = HKey_users
	echo                        HKCR = HKey_classes_root
	echo                    For example, to edit the current user's context menu, you can do the following:
	echo                    contextmenu "pre=HKCU\Software\Classes" [paramaters]
	echo                    Thankfully, this lets you use the command without admin, but it only works for the current user.
	echo                    For a computer with multiple users, you should probably use this, but it's still experimental.
	echo     [filetype]   : What file type to add the item to.
	echo                    "Directory" for folder backgrounds
	echo                    "LibraryFolder" for library folder backgrounds
	echo                    ".[extension]" for all files of an extension
	echo                    "*" for all files
	echo     [name]       : Internal name of the context menu item
	echo     [display]    : The text displayed in the context menu
	echo     [cmd]        : The program you want the item to run. ^(use "cmd.exe /c [your command]" for batch commands^)
	echo     [extended^|]  : If 1, the item will only be accessable via SHIFT+Right Click, otherwise it's just normal behaviour
	echo     [icon^|]      : The location of the icon for the item
	echo.
	echo.
	echo contextmenu del  : Remove item from context menu
	echo     [pre^|]       : See the description for [pre] in `contextmenu add` ^(Above^)
	echo     [filetype]   : See the description for [filetype] in `contextmenu add` ^(Above^)
	echo     [name]       : The internal name of the item to remove. ^(Not the display name^)
	echo.
goto :EOF
:afterhelp
if /i [%1]==[add] (
	:: Checking that paramaters 2-5 exist
	if [%2]==[] echo Invalid Format & goto :EOF
	if [%3]==[] echo Invalid Name & goto :EOF
	if [%4]==[] echo Invalid Display & goto :EOF
	if [%5]==[] echo Invalid Command & goto :EOF
	:: Add key+display name
	reg add %pre%\%2\shell\%3 /d %4 /f
	:: Add command
	reg add %pre%\%2\shell\%3\command /d %5 /f
	:: Add extended
	if [%6]==[1] reg add %pre%\%2\shell\%3 /v Extended /d "" /f
	:: Add icon
	if [%7] NEQ [] reg add %pre%\%2\shell\%3 /v Icon /d %7 /f
	goto :EOF
)
if /i [%1]==[del] (
	reg delete %pre%\%2\shell\%3 /f
)
:EOF
