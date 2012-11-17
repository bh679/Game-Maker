{
    var save_filename, stages, surface_handle, stage_start, stage_end, i, ii, save_filename_complete, save;
    
    save_filename = argument[0];
    stages = argument[1];
        // 1 = Save all stages.
        // 2 = Save only current stage.
        // 3 = Save all stages but current stage.
    
    surface_handle = surface_create(global.__rt_width, global.__rt_height);
    if(surface_exists(surface_handle))
    {
        surface_set_target(surface_handle);
        if(stages == 1)
        {
            stage_start = 0;
            stage_end = global.__rt_stage_current;
        }
        else if(stages == 2)
        {
            stage_start = global.__rt_stage_current;
            stage_end = global.__rt_stage_current;
        }
        else if(stages == 3)
        {
            stage_start = 0;
            stage_end = global.__rt_stage_current - 1;
        }
        for(s = stage_start; s <= stage_end; s += 1)
        {
            draw_clear_alpha(c_black, 0);
            for(i = 0; i <= s; i += 1)
            {
                for(ii = 0; ii < global.__rt_thread_count; ii += 1)
                {
                    if(sprite_exists(global.__rt_sprite_handle[i, ii]))
                    {
                        draw_sprite(global.__rt_sprite_handle[i, ii], 0, 0, 0);
                    }
                    else
                    {
                        show_message("Error:  Sprite does not exist in rendering stage " + string(i + 1) + " for thread " + string(ii + 1) + " to draw image.");
                    }
                }
            }
            save_filename_complete = filename_path(save_filename) + filename_change_ext(filename_name(save_filename), "") + " (Stage " + string(s + 1) + " of " + string(ds_list_size(global.__rt_list_stages)) + ")" + filename_ext(save_filename);
            if(file_exists(save_filename_complete))
            {
                if(show_question("The file " + chr(34) + save_filename_complete + chr(34) + " already exists.##Do you wish to overwrite it?"))
                {
                    save = true;
                }
                else
                {
                    save = false;
                }
            }
            else
            {
                save = true;
            }
            
            if(save)
            {
                surface_save(surface_handle, save_filename_complete);
                if(!file_exists(save_filename_complete))
                {
                    show_message("Error:  Image could not be saved at " + chr(34) + save_filename_complete + chr(34) + ".");
                }
            }
        }
        surface_reset_target();
        surface_free(surface_handle);
        if(show_question("Do you wish to open and view the image(s) in your default program?"))
        {
            for(s = stage_start; s <= stage_end; s += 1)
            {
                save_filename_complete = filename_path(save_filename) + filename_change_ext(filename_name(save_filename), "") + " (Stage " + string(s + 1) + " of " + string(ds_list_size(global.__rt_list_stages)) + ")" + filename_ext(save_filename);
                if(file_exists(save_filename_complete))
                {
                    execute_shell(save_filename_complete, "");
                }
            }
        }
    }
    else
    {
        show_message("Error:  Could not create surface on which to composite final image(s).");
    }
}
