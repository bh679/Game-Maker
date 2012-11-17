{
    var surface_handle, sprite_handle, px, py, fx, fy, lx, ly, lz, r, g, b, cr, cg, cb, dx, dy, dz, l, currentCol;
    
    surface_handle = -1;
    sprite_handle = -1;
    
    for(py = global.__rt_thread_current; py < global.__rt_height; py += global.__rt_thread_count)
    {
        lx = global.__rt_p1x + global.__rt_dyx * py;
        ly = global.__rt_p1y + global.__rt_dyy * py;
        lz = global.__rt_p1z + global.__rt_dyz * py;
        for(px = 0; px < global.__rt_width; px += 1)
        {
            r = 0;
            g = 0;
            b = 0;
            
            global.__rt_r = 0;
            global.__rt_g = 0;
            global.__rt_b = 0;
            currentCol = cl_CreateColor(0, 0, 0);
            dx = lx - global.__rt_originx;
            dy = ly - global.__rt_originy;
            dz = lz - global.__rt_originz;
            
            l = sqrt(dx * dx + dy * dy + dz * dz);
            dx /= l;
            dy /= l;
            dz /= l;
            
            global.__rt_list_depth = ds_list_create();
            global.__rt_list_color = ds_list_create();
            
            rt_ray_trace(global.__rt_originx, global.__rt_originy, global.__rt_originz, dx, dy, dz, currentCol, 1, 0, 0, 1, 1, 1);
            
            color_sum = 0;
            for(i = 0; i < ds_list_size(global.__rt_list_color); i += 1)
            {
                color_sum += ds_list_find_value(global.__rt_list_color, i);
            }
            if(color_sum == 0)
            {
                if(ds_list_size(global.__rt_list_color))
                {
                    color_sum = 1 / ds_list_size(global.__rt_list_color);
                }
                else
                {
                    color_sum = 1;
                }
            }
            pixel_depth = 0;
            for(i = 0; i < ds_list_size(global.__rt_list_color); i += 1)
            {
                pixel_depth += ds_list_find_value(global.__rt_list_depth, i) * ds_list_find_value(global.__rt_list_color, i) / color_sum;
            }
            ds_grid_set(global.__rt_grid_depth, px, py, pixel_depth);
            
            ds_list_destroy(global.__rt_list_depth);
            ds_list_destroy(global.__rt_list_color);
            
            r += cl_GetRed(currentCol);
            g += cl_GetGreen(currentCol);
            b += cl_GetBlue(currentCol);
            cl_Free(currentCol);
            
            if(!surface_exists(surface_handle))
            {
                surface_handle = surface_create(global.__rt_width, global.__rt_height);
                surface_set_target(surface_handle);
                draw_clear_alpha(c_black, 0);
                if(sprite_exists(sprite_handle))
                {
                    draw_sprite(sprite_handle, 0, 0, 0);
                }
                px -= 1;
            }
            else
            {
                color = make_color_rgb(median(0, r * 255, 255), median(0, g * 255, 255), median(0, b * 255, 255));
                draw_point_color(px, py, color);
                ds_grid_set(global.__rt_grid_color_r, px, py, r);
                ds_grid_set(global.__rt_grid_color_g, px, py, g);
                ds_grid_set(global.__rt_grid_color_b, px, py, b);
                lx += global.__rt_dxx;
                ly += global.__rt_dxy;
                lz += global.__rt_dxz;
            }
            if(!directory_exists(global.__rt_parent_directory))
            {
                global.__rt_exit_now = true;
                game_end();
                exit;
            }
            rt_pause_check();
        }
        if(sprite_exists(sprite_handle))
        {
            sprite_delete(sprite_handle);
        }
        sprite_handle = sprite_create_from_surface(surface_handle, 0, 0, global.__rt_width, global.__rt_height, false, false, 0, 0);
        sprite_save(sprite_handle, 0, global.__rt_parent_directory + "\Parent Process\Stage " + string(global.__rt_stage_current + 1) + "\Thread " + string(global.__rt_thread_current + 1) + "\Line " + string(py) + " Image.png");
    }
}
