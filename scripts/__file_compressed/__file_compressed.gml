/* 
# =================================================================== #
FileCompressed - By AntikoreDev
Save and load structs into binary-like files using buffers.
Available on Github at https://github.com/AntikoreDev/file-compressed
# =================================================================== #
*/

/**
 * @desc Loads the struct from a file saved previously with `file_compressed_save`
 *
 * @arg {string} filename Name of the file to load
 * @arg {any} default Value to return if loaded unsuccessfully, defaults to undefined
 *
 * @return {struct} JSON containing the data from the file or default if couldn't load correctly
 */

function file_compressed_load(_filename, _default = undefined){

	var _data_buffer = buffer_load(_filename);
	if (_data_buffer < 0)
		return _default;
	
	var _uncompressed_buffer = buffer_decompress(_data_buffer);
	if (_uncompressed_buffer < 0){
		buffer_delete(_data_buffer);
		return _default;
	}
	
	var _data_string = buffer_read(_uncompressed_buffer, buffer_string);
	
	buffer_delete(_uncompressed_buffer);
	buffer_delete(_data_buffer);
	
	var _data = _default;
	try {
		_data = json_parse(_data_string);
	} catch (e) {}

	return _data;
}

/**
 * @desc Asynchronously loads the struct from a file saved previously with `file_compressed_save`
 *
 * @arg {string} filename Path to the file
 *
 * @return {struct} Async Even ID `event_id` and buffer object `buffer` to parse with `file_compressed_load_parse`
 */

function file_compressed_load_async(_filename){

	var _data_buffer = buffer_create(16, buffer_grow, 1);
	var _event_id = buffer_load_async(_data_buffer, _filename, 0, -1);

	return {
		event_id: _event_id,
		buffer: _data_buffer
	};
}

/**
 * @desc Parses the data from a buffer loaded with `file_compressed_load_async` and converts it to an struct
 *
 * @arg {real} buffer Buffer ID to parse
 * @arg {any} default Value to return if loaded unsuccessfully, defaults to undefined
 *
 * @return {struct} JSON containing the data from the buffer or default if couldn't load correctly
 */

function file_compressed_load_parse(_buffer, _default = undefined){

	if (!buffer_exists(_buffer))
		return _default;
	
	var _uncompressed_buffer = buffer_decompress(_buffer);
	if (_uncompressed_buffer < 0){
		buffer_delete(_buffer);
		return _default;
	}
	
	var _data_string = buffer_read(_uncompressed_buffer, buffer_string);
	
	buffer_delete(_uncompressed_buffer);
	buffer_delete(_buffer);
	
	var _data = _default;
	try {
		_data = json_parse(_data_string);
	} catch (e) {}

	return _data;
}

/**
 * @desc Saves a json struct into the chosen filename as compressed data.
 *
 * @arg {string} filename  The file to save the file to
 * @arg {struct} data	   The json data to save onto the file
 *
 * @return {bool} true if success, otherwise false
 */
function file_compressed_save(_filename, _data){
	
	var _compressed_buffer = -1;
	var _data_buffer = -1;
	
	var _data_string = "";

	var _result = false;

	try {
		_data_string = json_stringify(_data);
		_data_buffer = buffer_create(256, buffer_grow, 1);

		buffer_seek(_data_buffer, buffer_seek_start, 0);
		buffer_write(_data_buffer, buffer_string, _data_string);
		
		_compressed_buffer = buffer_compress(_data_buffer, 0, buffer_tell(_data_buffer));
		buffer_save(_compressed_buffer, _filename);

		_result = true;
		
	} catch (e) {}

	if (buffer_exists(_compressed_buffer))
		buffer_delete(_compressed_buffer);

	if (buffer_exists(_data_buffer))
		buffer_delete(_data_buffer);
		
	return _result;
}

/**
 * @desc Asynchronously saves a json struct into the chosen filename as compressed data.
 *
 * @arg {string} filename  The file to save the file to
 * @arg {struct} data	   The json data to save onto the file
 *
 * @return {real} Async event ID
 */
function file_compressed_save_async(_filename, _data){
	
	var _compressed_buffer = -1;
	var _data_buffer = -1;

	var _data_string = "";

	var _event_id = -1;

	try {
		_data_string = json_stringify(_data);
		_data_buffer = buffer_create(256, buffer_grow, 1);

		buffer_seek(_data_buffer, buffer_seek_start, 0);
		buffer_write(_data_buffer, buffer_string, _data_string);
		
		_compressed_buffer = buffer_compress(_data_buffer, 0, buffer_tell(_data_buffer));
		_event_id = buffer_save_async(_compressed_buffer, _filename, 0, -1);

	} catch (e) {}

	if (buffer_exists(_compressed_buffer))
		buffer_delete(_compressed_buffer);

	if (buffer_exists(_data_buffer))
		buffer_delete(_data_buffer);
	
	return _event_id;
}
