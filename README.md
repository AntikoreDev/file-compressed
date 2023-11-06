# FileCompressed
<div align="center">
	<a href="https://github.com/AntikoreDev/file-compressed" onClick = "return false"><img alt = "Repo size" src = "https://img.shields.io/github/repo-size/AntikoreDev/file-compressed?style=for-the-badge"></a>
	<a href="https://github.com/AntikoreDev/file-compressed/stargazers"><img alt = "Stars" src = "https://img.shields.io/github/stars/AntikoreDev/file-compressed?style=for-the-badge"></a>
	<a href="https://github.com/AntikoreDev/file-compressed/releases"><img alt="GitHub all releases" src="https://img.shields.io/github/downloads/AntikoreDev/file-compressed/total?style=for-the-badge"></a>
	<a href="./LICENSE"><img alt="GitHub" src="https://img.shields.io/github/license/AntikoreDev/file-compressed?style=for-the-badge"></a>
</div>

Simple and ready to use GameMaker functions for saving/loading structs into binary-like files using buffers. Released for public domain under the [Unlicense](./LICENSE), credit is good but not mandatory :)

## How to install
- [Download the .yymps](https://github.com/AntikoreDev/file-compressed/releases)
- Drag it into your project
- Include the script into your project.

## Functions
This extension includes the following functions

### file_compressed_save(filename, data)
Saves the struct `data` into the chosen filename/path

### file_compressed_load(filename, default = undefined)
Loads and returns the data from `filename` as a struct, if any errors ocurr returns `default`

### file_compressed_save_async(filename, data)
Asynchronously aves the struct `data` into the chosen filename/path, returns the `event_id` for the async event call or `-1` if any errors where caught. _Take in account for GameMaker reasons, `filename` will include into a `default/` folder, thus it may not be used outside games for UWP_

### file_compressed_load_async(filename)
Loads data `filename` and returns an struct with the `event_id` and the `buffer` that will be populated with the data loaded. _Take in account for GameMaker reasons, `filename` will include into a `default/` folder, thus it may not be used outside games for UWP_

### file_compressed_load_parse(buffer, default = undefined)
Using a previously loaded `buffer` using `file_compressed_load_async`, convert it and return the resulting struct or `default` if errors ocurr

## Contributing
Feel free to open pull requests to improve the functions, however I'm not planning into doing any big additions soon.
Commit names should be using [Gitmoji](https://gitmoji.dev/) emoji standard

## Donating
If you want to support me, you can just buy me a coffee

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P7827IB)