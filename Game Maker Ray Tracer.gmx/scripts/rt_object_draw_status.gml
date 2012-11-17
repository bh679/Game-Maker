{
    var wait, i;
    
    global.__rt_progress = global.__rt_progress / global.__rt_height / global.__rt_thread_count / ds_list_size(global.__rt_list_stages);
    
    if(global.__rt_progress * ds_list_size(global.__rt_list_stages) >= global.__rt_stage_current + 1 && global.__rt_stage_current + 1 < ds_list_size(global.__rt_list_stages))
    {
        global.__rt_stage_current += 1;
        rt_object_spawn_stage(global.__rt_stage_current);
    }
    
    if(global.__rt_progress < 1)
    {
        global.__rt_time_elapsed = format_time(round((current_time - global.__rt_time_start) / 1000));
    }
    
    if(global.__rt_progress > 0)
    {
        ds_list_add(global.__rt_list_time_remaining, ((current_time - global.__rt_time_start) - (current_time - global.__rt_time_start) / global.__rt_progress) / 1000);
    }
    else
    {
        ds_list_add(global.__rt_list_time_remaining, "Calculating...");
    }
    if(ds_list_size(global.__rt_list_time_remaining) >= 5 * room_speed)
    {
        ds_list_delete(global.__rt_list_time_remaining, 0);
    }
    
    wait = false;
    for(i = 0; i < ds_list_size(global.__rt_list_time_remaining); i += 1)
    {
        if(!is_real(ds_list_find_value(global.__rt_list_time_remaining, i)))
        {
            wait = true;
        }
    }
    if(wait)
    {
        global.__rt_time_remaining = "Calculating...";
    }
    else
    {
        global.__rt_time_remaining = 0;
        if(global.__rt_progress < 1)
        {
            for(i = 0; i < ds_list_size(global.__rt_list_time_remaining); i += 1)
            {
                global.__rt_time_remaining += ds_list_find_value(global.__rt_list_time_remaining, i) / ds_list_size(global.__rt_list_time_remaining);
            }
        }
        global.__rt_time_remaining = format_time(round(abs(global.__rt_time_remaining)));
    }
    
    draw_text_shadow(10, 10, "Progress:  " + string(global.__rt_progress * 100) + "%  (stage " + string(global.__rt_stage_current + 1) + " of " +string(ds_list_size(global.__rt_list_stages)) + ")#Time Elapsed:  " + global.__rt_time_elapsed + "#Time Remaining:  " + global.__rt_time_remaining);
    if(global.__rt_progress == 1)
    {
        draw_text_shadow(10, 10, "####COMPLETED (press S to save)");
    }
}
