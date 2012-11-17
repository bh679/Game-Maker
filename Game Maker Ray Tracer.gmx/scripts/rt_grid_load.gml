{
    var thread, grid_temp, file_handle, grid_string;
    
    thread = argument[0];
    
    path_output = global.__rt_parent_directory + "\Slave Process(es)\Roaming Data\Stage " + string(global.__rt_stage_current) + "\Thread " + string(thread + 1);
    while(!file_exists(path_output + "\Save Completed.txt"))
    {
        // Wait for the previous thread to finish saving all the grid information files.
    }
    grid_temp = ds_grid_create(global.__rt_width, global.__rt_height);
    
    file_handle = file_text_open_read(path_output + "\Color Red Grid.txt");
    if(file_handle == -1)
    {
        show_message("Error:  Could not open file to read grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
    }
    else
    {
        grid_string = file_text_read_string(file_handle);
        file_text_close(file_handle);
        ds_grid_read(grid_temp, grid_string);
        ds_grid_add_grid_region(global.__rt_grid_color_r, grid_temp, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
        
        file_handle = file_text_open_read(path_output + "\Color Green Grid.txt");
        if(file_handle == -1)
        {
            show_message("Error:  Could not open file to read grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
        }
        else
        {
            grid_string = file_text_read_string(file_handle);
            file_text_close(file_handle);
            ds_grid_read(grid_temp, grid_string);
            ds_grid_add_grid_region(global.__rt_grid_color_g, grid_temp, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
            
            file_handle = file_text_open_read(path_output + "\Color Blue Grid.txt");
            if(file_handle == -1)
            {
                show_message("Error:  Could not open file to read grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
            }
            else
            {
                grid_string = file_text_read_string(file_handle);
                file_text_close(file_handle);
                ds_grid_read(grid_temp, grid_string);
                ds_grid_add_grid_region(global.__rt_grid_color_b, grid_temp, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
                
                file_handle = file_text_open_read(path_output + "\Depth Grid.txt");
                if(file_handle == -1)
                {
                    show_message("Error:  Could not open file to read grid information for next stage at " + chr(34) + file_path + chr(34) + ".");
                }
                else
                {
                    grid_string = file_text_read_string(file_handle);
                    file_text_close(file_handle);
                    ds_grid_read(grid_temp, grid_string);
                    ds_grid_add_grid_region(global.__rt_grid_depth, grid_temp, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
                }
            }
        }
    }
    
    ds_grid_destroy(grid_temp);
}
