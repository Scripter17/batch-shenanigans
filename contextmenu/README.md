# Contextmenu
![Jank: 100%](https://img.shields.io/badge/Jank-100%25-red.svg)

You know that menu that shows up whenever you right-click a file? That thing is called a context menu. Many programs modify it in order to make using said program more convenient.

You may want to add some stuff to it yourself, but going through the registry can be a hassle, and using a program might not give you all the features you want. That is why I created this program. It's a simple command-line interface that allows you to add stuff to the context menu simply.
## The help command
```batch
contextmenu /?
```

## Basic usage
```batch
contextmenu add [dir|lib] [name] [display] [cmd]
```
This adds an item to the context menu that is displayed as `[display]`, and runs `[cmd]` when clicked. `[name]` is simply the name given to the registry key containing the item.
Note: Library folders (Documents, Pictures, etc.) are not affected by `contextmenu add dir ...` commands, and vice versa. There's probably some other example of this, and if so, please tell me.

Now some context menu items only appear when you're holding `shift`, and some even have icons. I have implemented this by adding the `[extended]` and `[icon]` parameters:
```batch
contextmenu add [dir|lib] [name] [display] [cmd] [extension|] [icon|]
```
Due to some batch quirkiness and programmer laziness, the `[extension]` parameter only does anything if its value is `1`.

## Concrete example
A simple use for editing the context menu is having an "Open CMD Here" button. Hence it is the perfect example command to show.
```batch
contextmenu add dir cmd_here "Open CMD here" cmd.exe 0 "C:\WINDOWS\system32\cmd.exe, 0"
```
This command adds the following item to the context menu for folder backgrounds.

![Error: Image failed to load](https://raw.githubusercontent.com/Scripter17/batch-shenanigans/master/assets/context1.png)

So instead of running `cd C:\Path\to\folder\`, just open the folder in the file explorer, and click "Open CMD Here"!