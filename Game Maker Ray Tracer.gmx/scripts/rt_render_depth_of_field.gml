{
    /*
        Argument0 = Number of threads.
        Argument1 = Starting offset.
        Argument2 = Directory in which to store output images.
    */
    
    var surface_handle, sprite_handle, grid_new_color_r, grid_new_color_g, grid_new_color_b, px, py, fx, fy, lx, ly, lz, r, g, b, cr, cg, cb, dx, dy, dz, l, currentCol;
    
    surface_handle = -1;
    sprite_handle = -1;
    
    grid_new_color_r = ds_grid_create(global.__rt_width, global.__rt_height);
    grid_new_color_g = ds_grid_create(global.__rt_width, global.__rt_height);
    grid_new_color_b = ds_grid_create(global.__rt_width, global.__rt_height);
    
    for(py = global.__rt_thread_current; py < global.__rt_height; py += global.__rt_thread_count)
    {
        for(px = 0; px < global.__rt_width; px += 1)
        {
            blur_amount = (ds_grid_get(global.__rt_grid_depth, px, py) - global.__rt_dof_focus_depth) * global.__rt_dof_focus_scale;
            
            blur_radius_x = 0;
            while(gaussian_value(blur_radius_x / global.__rt_width, 0, blur_amount) > 1 / 255)
            {
                blur_radius_x += 1;
            }
            blur_radius_y = 0;
            while(gaussian_value(0, blur_radius_y / global.__rt_height, blur_amount) > 1 / 255)
            {
                blur_radius_y += 1;
            }
            
            sum = 0;
            for(by = -blur_radius_y; by <= blur_radius_y; by += 1)
            {
                for(bx = -blur_radius_x; bx <= blur_radius_x; bx += 1)
                {
                    if((px + bx >= 0) && (px + bx < global.__rt_width) && (py + by >= 0) && (py + by < global.__rt_height))
                    {
                        sum += gaussian_value(bx / global.__rt_width, by / global.__rt_height, (ds_grid_get(global.__rt_grid_depth, px + bx, py + by) - global.__rt_dof_focus_depth) * global.__rt_dof_focus_scale);
                    }
                }
            }
            
            r = 0;
            g = 0;
            b = 0;
            for(by = -blur_radius_y; by <= blur_radius_y; by += 1)
            {
                for(bx = -blur_radius_x; bx <= blur_radius_x; bx += 1)
                {
                    if((px + bx >= 0) && (px + bx < global.__rt_width) && (py + by >= 0) && (py + by < global.__rt_height))
                    {
                        s = gaussian_value(bx / global.__rt_width, by / global.__rt_height, (ds_grid_get(global.__rt_grid_depth, px + bx, py + by) - global.__rt_dof_focus_depth) * global.__rt_dof_focus_scale) / sum;
                        r += s * ds_grid_get(global.__rt_grid_color_r, px + bx, py + by);
                        g += s * ds_grid_get(global.__rt_grid_color_g, px + bx, py + by);
                        b += s * ds_grid_get(global.__rt_grid_color_b, px + bx, py + by);
                    }
                }
            }
            
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
                ds_grid_set(grid_new_color_r, px, py, r);
                ds_grid_set(grid_new_color_g, px, py, g);
                ds_grid_set(grid_new_color_b, px, py, b);
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
    
    ds_grid_set_grid_region(global.__rt_grid_color_r, grid_new_color_r, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
    ds_grid_set_grid_region(global.__rt_grid_color_g, grid_new_color_g, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
    ds_grid_set_grid_region(global.__rt_grid_color_b, grid_new_color_b, 0, 0, global.__rt_width, global.__rt_height, 0, 0);
}
