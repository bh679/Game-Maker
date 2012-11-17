{
    /*
        Argument0 = X
        Argument1 = Y
        Argument2 = Z
        Argument3 = Directional X
        Argument4 = Directional Y
        Argument5 = Directional Z
        Argument6 = Color handle
        Argument7 = Current refractive index
        Argument8 = Ray depth (number of subsequent ray casts)
        Argument9 = Current total distance traveled by ray
        Argument10 = Current red color percentage able to be shown by current ray
        Argument11 = Current green color percentage able to be shown by current ray
        Argument12 = Current blue color percentage able to be shown by current ray
    */
    
    var px, py, pz, dirx, diry, dirz, col, current_refraction_index, ray_depth, ray_distance, percentage_r, percentage_g, percentage_b;
    var t, c, nx, ny, nz, r, i, rd, vx, vy, vz, lvx, lvy, lvz, l, red, green, blue, lambert, phong, svx, svy, svz, m, shade, reflx, refly, reflz, refrx, refry, refrz;
    
    px = argument0;
    py = argument1;
    pz = argument2;
    dirx = argument3;
    diry = argument4;
    dirz = argument5;
    col = argument6;
    current_refraction_index = argument7;
    ray_depth = argument8;
    ray_distance = argument9;
    percentage_r = argument10;
    percentage_g = argument11;
    percentage_b = argument12;
    
    t = 1000000000;
    c = -1;
    for(i = 0; i < global.__rt_numShapes; i += 1)
    {
        global.shadow_test = false;
        rd = sh_RayCast(px, py, pz, dirx, diry, dirz, i);
        if(rd == true && global.ry_t < t)
        {
            t = global.ry_t;
            nx = global.ry_nx;
            ny = global.ry_ny;
            nz = global.ry_nz;
            r = global.ry_r;
            c = i;
        }
    }
    if(c == -1)
    {
        // Ray did not intersect any shapes (should not add any color).
        return false;
    }
    m = global.__rt_shapes[c, 7];
    vx = px + dirx * t;
    vy = py + diry * t;
    vz = pz + dirz * t;
    
    for(i = 0; i < global.lt_numLights; i += 1)
    {
        lvx = global.lt_lights[i, 1] - vx;
        lvy = global.lt_lights[i, 2] - vy;
        lvz = global.lt_lights[i, 3] - vz;
        l = sqrt(lvx * lvx + lvy * lvy + lvz * lvz);
        lvx /= l;
        lvy /= l;
        lvz /= l;
        
        // Compensate for distance and determine shade using the forumla for intensity = P / (4 * pi * r * r).
        shade = 1 / (4 * pi * l * l);
        shade *= lt_InLight(i, -lvx, -lvy, -lvz);
        shade *= lt_InShadow(i, vx - dirx * EPSILON, vy - diry * EPSILON, vz - dirz * EPSILON, lvx, lvy, lvz, t);
        if(shade <= 0)
        {
            continue;
        }
        
        lambert = lvx * nx + lvy * ny + lvz * nz;
        if(lambert > 0)
        {
            red = shade * global.cl_colors[global.lt_lights[i, 4], 0] * global.cl_colors[global.mat_materials[m, 0], 0] * lambert;
            cl_IncreaseRed(col, red);
            green = shade * global.cl_colors[global.lt_lights[i, 4], 1] * global.cl_colors[global.mat_materials[m, 0], 1] * lambert;
            cl_IncreaseGreen(col, green);
            blue = shade * global.cl_colors[global.lt_lights[i, 4], 2] * global.cl_colors[global.mat_materials[m, 0], 2] * lambert;
            cl_IncreaseBlue(col, blue);
            ds_list_add(global.__rt_list_depth, ray_distance + t);
            ds_list_add(global.__rt_list_color, red + green + blue);
        }
        
        svx = px - vx;
        svy = py - vy;
        svz = pz - vz;
        l = sqrt(svx * svx + svy * svy + svz * svz);
        svx /= l;
        svy /= l;
        svz /= l;
        
        phong = (nx * 2 * lambert - lvx) * svx + (ny * 2 * lambert - lvy) * svy + (nz * 2 * lambert - lvz) * svz;
        if(phong > 0)
        {
            phong = power(phong, global.mat_materials[m, 2]);
            red = shade * global.cl_colors[global.lt_lights[i, 4], 0] * global.cl_colors[global.mat_materials[m, 1], 0] * phong;
            cl_IncreaseRed(col, red);
            green = shade * global.cl_colors[global.lt_lights[i, 4], 1] * global.cl_colors[global.mat_materials[m, 1], 1] * phong;
            cl_IncreaseGreen(col, green);
            blue = shade * global.cl_colors[global.lt_lights[i, 4], 2] * global.cl_colors[global.mat_materials[m, 1], 2] * phong;
            cl_IncreaseBlue(col, blue);
            ds_list_add(global.__rt_list_depth, ray_distance + t);
            ds_list_add(global.__rt_list_color, red + green + blue);
        }
    }
    
    var reflect_r, reflect_g, reflect_b, reflCol, refrCol, refraction_index, refract_r, refract_g, refract_b;
    visible_light = min(percentage_r, percentage_g, percentage_b);
    if(ray_depth < global.__rt_maxTraceDepth && visible_light >= global.__rt_visibility_limit)// Only continue if the ray has bounced only a certain number of times.
    {
        reflect_r = global.cl_colors[global.mat_materials[m, 3], 0];
        reflect_g = global.cl_colors[global.mat_materials[m, 3], 1];
        reflect_b = global.cl_colors[global.mat_materials[m, 3], 2];
        if(reflect_r != 0 || reflect_g != 0 || reflect_b != 0)
        {
            dot = nx * dirx + ny * diry + nz * dirz;
            reflx = dirx - nx * 2 * dot;
            refly = diry - ny * 2 * dot;
            reflz = dirz - nz * 2 * dot;
            
            reflCol = cl_CreateColor(0, 0, 0);
            rt_ray_trace(vx + reflx * EPSILON, vy + refly * EPSILON, vz + reflz * EPSILON, reflx, refly, reflz, reflCol, global.mat_materials[m, 5], ray_depth + 1, ray_distance + t, percentage_r * reflect_r, percentage_g * reflect_g, percentage_b * reflect_b);
            
            // Do not replace with reflect_* because the values are changed after calling rt_ray_trace().
            red = global.cl_colors[reflCol, 0] * global.cl_colors[global.mat_materials[m, 3], 0];
            cl_IncreaseRed(col, red);
            green = global.cl_colors[reflCol, 1] * global.cl_colors[global.mat_materials[m, 3], 1];
            cl_IncreaseGreen(col, green);
            blue = global.cl_colors[reflCol, 2] * global.cl_colors[global.mat_materials[m, 3], 2];
            cl_IncreaseBlue(col, blue);
            
            cl_Free(reflCol);
            
            ds_list_add(global.__rt_list_depth, ray_distance + t);
            ds_list_add(global.__rt_list_color, red + green + blue);
        }
        
        refraction_index = global.mat_materials[m, 5];
        if(refraction_index != 0)
        {
            refract_r = global.cl_colors[global.mat_materials[m, 4], 0];
            refract_g = global.cl_colors[global.mat_materials[m, 4], 1];
            refract_b = global.cl_colors[global.mat_materials[m, 4], 2];
            if(refract_r != 0 || refract_g != 0 || refract_b != 0)
            {
                rt_refract(dirx, diry, dirz, nx, ny, nz, global.mat_materials[m, 5], r == 1);
                refrx = global.__rt_refractx;
                refry = global.__rt_refracty;
                refrz = global.__rt_refractz;
                refrCol = cl_CreateColor(0, 0, 0);
                rt_ray_trace(vx + refrx * EPSILON, vy + refry * EPSILON, vz + refrz * EPSILON, refrx, refry, refrz, refrCol, global.mat_materials[m, 5], ray_depth + 1, ray_distance + t, percentage_r * refract_r, percentage_g * refract_g, percentage_b * refract_b);
                
                red = global.cl_colors[refrCol, 0] * global.cl_colors[global.mat_materials[m, 4], 0];
                cl_IncreaseRed(col, red);
                green = global.cl_colors[refrCol, 1] * global.cl_colors[global.mat_materials[m, 4], 1];
                cl_IncreaseGreen(col, green);
                blue = global.cl_colors[refrCol, 2] * global.cl_colors[global.mat_materials[m, 4], 2];
                cl_IncreaseBlue(col, blue);
                
                cl_Free(refrCol);
                
                ds_list_add(global.__rt_list_depth, ray_distance + t);
                ds_list_add(global.__rt_list_color, red + green + blue);
            }
        }
    }
}
