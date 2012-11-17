{
    var i;
    
    window_set_visible(false);
    set_program_priority(-2);// Low priority.
    
    if(file_exists(parameter_string(2)))
    {
        execute_file(parameter_string(2));// Load information and custom parameters from parent process.
    }
    else
    {
        game_end();
        exit;
    }
    rt_init();
    rt_define_image();// Make image changes in this script!
    
    switch(ds_list_find_value(global.__rt_list_stages, global.__rt_stage_current))
    {
        case "render_original":
        {
            rt_render_original();
            break;
        }
        case "render_smart_aa":
        {
            for(i = 0; i < global.__rt_thread_count; i += 1)// Piece together from each thread.
            {
                rt_grid_load(i);
            }
            rt_render_smart_aa();
            break;
        }
        case "render_depth_of_field":
        {
            for(i = 0; i < global.__rt_thread_count; i += 1)// Piece together from each thread.
            {
                rt_grid_load(i);
            }
            rt_render_depth_of_field();
            break;
        }
    }
    
    if(!global.__rt_exit_now)
    {
        rt_grid_save();
    }
    
    game_end();
}
