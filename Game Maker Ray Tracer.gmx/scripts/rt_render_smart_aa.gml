{
    var surface_handle, sprite_handle, inverse_aa_squared, px, py, ax, ay, lx, ly, lz, r, g, b, cr, cg, cb;
    var dx, dy, dz, l, currentCol, aa_pixel, co, co_h, co_s, co_v, tx, ty, ct, ct_h, ct_s, ct_v;
    
    surface_handle = -1;
    sprite_handle = -1;
    inverse_aa_squared = 1 / (global.__rt_aaLevel * global.__rt_aaLevel);
    
    for(py = global.__rt_thread_current; py < global.__rt_height; py += global.__rt_thread_count)
    {
        lx = global.__rt_p1x + global.__rt_dyx * py;
        ly = global.__rt_p1y + global.__rt_dyy * py;
        lz = global.__rt_p1z + global.__rt_dyz * py;
        for(px = 0; px < global.__rt_width; px += 1)
        {
            aa_pixel = false;
            r = ds_grid_get(global.__rt_grid_color_r, px, py);
            g = ds_grid_get(global.__rt_grid_color_g, px, py);
            b = ds_grid_get(global.__rt_grid_color_b, px, py);
            co = make_color_rgb(median(0, r * 255, 255), median(0, g * 255, 255), median(0, b * 255, 255));
            co_h = color_get_hue(co);
            co_s = color_get_saturation(co);
            co_v = color_get_value(co);
            for(ty = -1; ty <= 1; ty += 1)
            {
                for(tx = -1; tx <= 1; tx += 1)
                {
                    if(!(tx == 0 && ty == 0))
                    {
                        r = ds_grid_get(global.__rt_grid_color_r, px + tx, py + ty);
                        g = ds_grid_get(global.__rt_grid_color_g, px + tx, py + ty);
                        b = ds_grid_get(global.__rt_grid_color_b, px + tx, py + ty);
                        ct = make_color_rgb(median(0, r * 255, 255), median(0, g * 255, 255), median(0, b * 255, 255));
                        ct_h = co_h - color_get_hue(ct);
                        ct_s = co_s - color_get_saturation(ct);
                        ct_v = co_v - color_get_value(ct);
                        
                        if(abs(ct_h) > global.__rt_aa_color_limit || abs(ct_s) > global.__rt_aa_color_limit || abs(ct_v) > global.__rt_aa_color_limit)
                        {
                            aa_pixel = true;
                            ty = 1;
                            tx = 1;
                            // Force break from testing adjacent pixels.
                        }
                    }
                }
            }
            if(aa_pixel)
            {
                global.__rt_list_depth = ds_list_create();
                global.__rt_list_color = ds_list_create();
                // Optimize AA by using the (0, 0) sub-sample already calculated by the original image rendering pass.
                r = ds_grid_get(global.__rt_grid_color_r, px, py) * inverse_aa_squared;
                g = ds_grid_get(global.__rt_grid_color_g, px, py) * inverse_aa_squared;
                b = ds_grid_get(global.__rt_grid_color_b, px, py) * inverse_aa_squared;
                ds_list_add(global.__rt_list_depth, ds_grid_get(global.__rt_grid_depth, px, py));
                ds_list_add(global.__rt_list_color, r / inverse_aa_squared + g / inverse_aa_squared + b / inverse_aa_squared);
                for(ax = 0; ax < global.__rt_aaLevel; ax += 1)
                {
                    for(ay = 0; ay < global.__rt_aaLevel; ay += 1)
                    {
                        if(ax == 0 && ay == 0)
                        {
                            continue;
                        }
                        global.__rt_r = 0;
                        global.__rt_g = 0;
                        global.__rt_b = 0;
                        currentCol = cl_CreateColor(0, 0, 0);
                        dx = lx + global.__rt_dxx * ax / global.__rt_aaLevel + global.__rt_dyx * ay / global.__rt_aaLevel - global.__rt_originx;
                        dy = ly + global.__rt_dxy * ax / global.__rt_aaLevel + global.__rt_dyy * ay / global.__rt_aaLevel - global.__rt_originy;
                        dz = lz + global.__rt_dxz * ax / global.__rt_aaLevel + global.__rt_dyz * ay / global.__rt_aaLevel - global.__rt_originz;
                        
                        l = sqrt(dx * dx + dy * dy + dz * dz);
                        dx /= l;
                        dy /= l;
                        dz /= l;
                        
                        rt_ray_trace(global.__rt_originx, global.__rt_originy, global.__rt_originz, dx, dy, dz, currentCol, 1, 0, 0, 1, 1, 1);
                        
                        r += cl_GetRed(currentCol) * inverse_aa_squared;
                        g += cl_GetGreen(currentCol) * inverse_aa_squared;
                        b += cl_GetBlue(currentCol) * inverse_aa_squared;
                        cl_Free(currentCol);
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
                if(aa_pixel)
                {
                    color = make_color_rgb(median(0, r * 255, 255), median(0, g * 255, 255), median(0, b * 255, 255));
                    draw_point_color(px, py, color);
                    ds_grid_set(global.__rt_grid_color_r, px, py, r);
                    ds_grid_set(global.__rt_grid_color_g, px, py, g);
                    ds_grid_set(global.__rt_grid_color_b, px, py, b);
                    
                    color_sum = 0;
                    for(i = 0; i < ds_list_size(global.__rt_list_color); i += 1)
                    {
                        color_sum += ds_list_find_value(global.__rt_list_color, i);
                    }
                    pixel_depth = 0;
                    for(i = 0; i < ds_list_size(global.__rt_list_color); i += 1)
                    {
                        pixel_depth += ds_list_find_value(global.__rt_list_depth, i) * ds_list_find_value(global.__rt_list_color, i) / color_sum;
                    }
                    ds_grid_set(global.__rt_grid_depth, px, py, pixel_depth);
                    
                    ds_list_destroy(global.__rt_list_depth);
                    ds_list_destroy(global.__rt_list_color);
                }
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
