{
    var scale_w, scale_h, scale, offset_x, offset_y, i, ii, file_path, sprite_handle_temp;
    
    scale_w = room_width / global.__rt_width;
    scale_h = room_height / global.__rt_height;
    scale = min(scale_w, scale_h);
    offset_x = (room_width - global.__rt_width * scale) / 2;
    offset_y = (room_height - global.__rt_height * scale) / 2;
    
    global.__rt_progress = 0;
    
    for(i = 0; i <= global.__rt_stage_current; i += 1)
    {
        for(ii = 0; ii < global.__rt_thread_count; ii += 1)
        {
            file_path = temp_directory + "\Parent Process\Stage " + string(i + 1) + "\Thread " + string(ii + 1) + "\Line " + string(global.__rt_image_current[i, ii] + global.__rt_thread_count) + " Image.png";
            if(file_exists(file_path))
            {
                sprite_handle_temp = sprite_add(file_path, 1, false, false, 0, 0);
                if(sprite_handle_temp != -1)
                {
                    if(sprite_exists(global.__rt_sprite_handle[i, ii]))
                    {
                        sprite_delete(global.__rt_sprite_handle[i, ii]);
                    }
                    global.__rt_sprite_handle[i, ii] = sprite_handle_temp;
                    global.__rt_image_current[i, ii] += global.__rt_thread_count;
                    //file_delete(file_path);
                }
            }
            
            if(sprite_exists(global.__rt_sprite_handle[i, ii]))
            {
                draw_sprite_ext(global.__rt_sprite_handle[i, ii], 0, offset_x, offset_y, scale, scale, 0, c_white, 1);
            }
            
            global.__rt_progress += global.__rt_image_current[i, ii] - (ii - global.__rt_thread_count);
        }
    }
}
