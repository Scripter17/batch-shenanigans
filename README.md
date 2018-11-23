# batch shenanigans
![Jank: 100%](https://img.shields.io/badge/Jank-100%25-red.svg)
## Contextmenu (TODO: Make this description not garbage)
You know that list of buttons that shows up when you right click a file/in a folder in Windows? That thing is called a "context menu". Adding stuff to it via the registry is a nightmare, and most editor programs (that I've tried) are... not that good. Thus, instead of doing my school work, I decided to make this spaghetti. It's a command line interface for adding/removing stuff from the context menu!
### Standard-issue help command:
```batch
contextmenu /?
```
### Adding a command to the folder background's context menu
```batch
contextmenu add dir [Registry name] [List item name] [Command] [extended?] [Icon location?]
```
1. The `extended` parameter is `1` if the item should only appear when holding shift while right-clicking.
2. The `extended` and `Icon location` parameters are optional (as demonstrated by the `?`)
### Remove that command
```batch
contextmenu del dir [Registry name]
```
### Adding an item to the context menu of a file type
```batch
contextmenu addf [extension] [Registry name] [List item name] [Command] [extended?] [Icon location?]
```
### Remove that command
```batch
contextmenu delf [extension] [Registry name]
```
