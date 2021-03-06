# Contextmenu
![Jank: 100%](https://img.shields.io/badge/Jank-100%25-red.svg)

You know that menu that shows up whenever you right-click a file? That thing is called a context menu. Many programs modify it in order to make using said program more convenient.

You may want to add some stuff to it yourself, but going through the registry can be a hassle, and using a program might not give you all the features you want. That is why I created this program. It's a simple command-line interface that allows you to add stuff to the context menu simply.
## The help command
```batch
contextmenu /?
```

## Usage
This command has the following syntax:

Function | Syntax
:-:|:-:
Adding an item | <code>contextmenu [pre&#124;] add [type] [name] [display] [cmd] [extended&#124;] [icon&#124;]</code>
Removing an item | <code>contextmenu [pre&#124;] del [type] [name]</code>

Parameter | Description | Input format
:-:|:-|:-:
<code>[pre&#124;]</code> | (Optional) An experimental feature that lets you add context menu items to single users at a time.<br/>When set to `"pre=HKCU\Software\Classes"`, the rest of the command will only affect the current user. When excluded, this defaults to `"pre=HKCR"`. | `"pre=[registry path]"`
`[type]`|The type of file/folder to apply the context item to.<br/>Example values:<br/>`Directory\Background` - Folder backgrounds (explorer and desktop)<br/>`LibraryFolder\Background` - The same as `Directory`, but for folders in a library (Pictures, Documents, etc.)<br/>`Directory` - Like `Directory\Background`, except it's for directory items in a folder. (Right clicking a link to `/stuff`, and not inside `/stuff`)<br/>`.[file extension]` - Right clicking files of a certain extension in a directory<br/>`*` - Right clicking files of any extension|String
`[name]`|The internal name of the registry key holding the context menu item.|String without spaces
`[display]`|The name of the item that appears in the context menu.|String, put `&` before a keyboard shortcut.<br/>(`&CMD` will activate when `C` is pressed)
`[cmd]`|The command to run when the item is clicked.|String<br/>`"cmd /c [commands]"` if it's meant to run batch code
<code>[extended&#124;]</code>|(Optional) `1` if the item should only appear when the user is holding shift, any other value otherwise.|See left
<code>[icon&#124;]</code>|A path to an icon for the menu item.<br/>If the icon is in a `.dll` file, you might need to add `, [number]` after the file name to get the right icon. For more info, just Google it.|String

### The GUI
This command also comes with two extra files: `contextmenu.ahk` and `contextmenu.ahk.exe`. `contextmenu.ahk` is an [AutoHotKey](https://www.autohotkey.com/) script that gives a simple GUI interface for adding and deleting items without using command prompt. `contextmenu.ahk.exe` is an exe version of the script, for use on computers without AHK installed.

![The GUI](/assets/gui1.png)

## Examples

A common use of editing the context menu is simply to add an "Open CMD here" item. To do this with the `contextmenu` command, simply run the following:

```batch
contextmenu add Directory\Background cmd_here "Open CMD here" cmd.exe 0 "C:\WINDOWS\system32\cmd.exe"
```

Or, if you don't have admin access or if you only want to add the item for yourself:

```batch
contextmenu "pre=HKCU\Software\Classes" add Directory\Background cmd_here "Open CMD here" cmd.exe 0 "C:\WINDOWS\system32\cmd.exe"
```

Now, this syntax is... unwieldy, at best. But, if you dissect it, it's clear that it is far more practical than editing the registry manually.

So, what if you want to remove the item? Use `contextmenu del Directory\background cmd_here`, or, for the second current-user-only command, `contextmenu "path=HKCU\Software\Classes" del Directory\background cmd_here`.