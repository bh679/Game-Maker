{
    var i, path_init, file_handle;
    
    for(i = 0; i < global.__rt_thread_count; i += 1)
    {
        path_init = temp_directory + "\Slave Process(es)\Local Data\Thread " + string(i + 1) + "\Init.gml";
        file_handle = file_text_open_write(path_init);
        
        file_text_write_string(file_handle, "global.__rt_parent_directory = " + chr(34) + temp_directory + chr(34) + ";");
        file_text_writeln(file_handle);
        file_text_write_string(file_handle, "global.__rt_thread_current = " + string(i) + ";");
        file_text_writeln(file_handle);
        file_text_write_string(file_handle, "global.__rt_thread_count = " + string(global.__rt_thread_count) + ";");
        file_text_writeln(file_handle);
        file_text_write_string(file_handle, "global.__rt_stage_current = " + string(global.__rt_stage_current) + ";");
        file_text_writeln(file_handle);
        // Pass information for custom (optional) parameters.
        file_text_write_string(file_handle, "global.__rt_width = " + string(global.__rt_width) + ";");
        file_text_writeln(file_handle);
        file_text_write_string(file_handle, "global.__rt_height = " + string(global.__rt_height) + ";");
        file_text_writeln(file_handle);
        file_text_write_string(file_handle, "global.__rt_aaLevel = " + string(global.__rt_aa_level) + ";");
        file_text_writeln(file_handle);
        
        file_text_close(file_handle);
        
        global.__rt_image_current[global.__rt_stage_current, i] = i - global.__rt_thread_count;
        global.__rt_sprite_handle[global.__rt_stage_current, i] = -1;
        execute_program(parameter_string(0),
                        "slave " + chr(34) + path_init + chr(34),
                        false);
    }
}
