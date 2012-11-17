{
    var path_output, i, file_path, file_handle;
    
    path_output = global.__rt_parent_directory + "\Slave Process(es)\Roaming Data\Stage " + string(global.__rt_stage_current + 1) + "\Thread " + string(global.__rt_thread_current + 1);
    
    
    
    for(i = 0; i < global.__rt_height; i += 1)
    {
        // If line i was not rendered by the current thread, erase its left over, old data before saving.
        if((i - global.__rt_thread_current) mod global.__rt_thread_count != 0)
        {
            ds_grid_set_region(global.__rt_grid_color_r, 0, i, global.__rt_width, i, 0);
            ds_grid_set_region(global.__rt_grid_color_g, 0, i, global.__rt_width, i, 0);
            ds_grid_set_region(global.__rt_grid_color_b, 0, i, global.__rt_width, i, 0);
            ds_grid_set_region(global.__rt_grid_depth, 0, i, global.__rt_width, i, 0);
        }
    }
    
    file_path = path_output + "\Color Red Grid.txt";
    file_handle = file_text_open_write(file_path);
    if(file_handle == -1)
    {
        show_message("Error:  Could not open file to save grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
    }
    else
    {
        file_text_write_string(file_handle, ds_grid_write(global.__rt_grid_color_r));
        file_text_close(file_handle);
        
        file_path = path_output + "\Color Green Grid.txt";
        file_handle = file_text_open_write(file_path);
        if(file_handle == -1)
        {
            show_message("Error:  Could not open file to save grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
        }
        else
        {
            file_text_write_string(file_handle, ds_grid_write(global.__rt_grid_color_g));
            file_text_close(file_handle);
            
            file_path = path_output + "\Color Blue Grid.txt";
            file_handle = file_text_open_write(file_path);
            if(file_handle == -1)
            {
                show_message("Error:  Could not open file to save grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
            }
            else
            {
                file_text_write_string(file_handle, ds_grid_write(global.__rt_grid_color_b));
                file_text_close(file_handle);
                
                file_path = path_output + "\Depth Grid.txt";
                file_handle = file_text_open_write(file_path);
                if(file_handle == -1)
                {
                    show_message("Error:  Could not open file to save grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
                }
                else
                {
                    file_text_write_string(file_handle, ds_grid_write(global.__rt_grid_depth));
                    file_text_close(file_handle);
                    
                    file_path = path_output + "\Save Completed.txt";
                    file_handle = file_text_open_write(file_path);
                    if(file_handle == -1)
                    {
                        show_message("Error:  Could not open file to save grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
                    }
                    else
                    {
                        file_text_close(file_handle);
                    }
                }
            }
        }
    }
}
