{
    set_application_title(room_caption);
    window_set_caption(room_caption);
    draw_clear(background_color);
    screen_refresh();
    
    if(parent_get_rt_settings())
    {
        if(parent_create_temp_folders())
        {
            global.__rt_stage_current = 0;
            global.__rt_time_start = current_time;
            global.__rt_time_elapsed = 0;
            global.__rt_list_time_remaining = ds_list_create();
            global.__rt_time_remaining = "Calculating...";
            global.__rt_progress = 0;
            rt_object_spawn_stage(global.__rt_stage_current);
        }
        else
        {
            game_end();
        }
    }
    else
    {
        game_end();
    }
}
