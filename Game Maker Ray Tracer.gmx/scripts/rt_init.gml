{
    /*
        Increased anti-aliasing increases the quality (smoothness and accuracy) of the image, but
        takes longer to render.  This number squared is the number of rays shot per end-pixel, as
        you are really rendering an image, say, 4 times the width and height of the image (16 times
        the area), then squeezing all that data into the correct image size.
        This should be set from 1 to 8 (after this there is no real gain in quality).
        
        Maximum ray tracing depth is the number of reflection/refraction bounces before a ray is calculated.
    */
    
    //global.__rt_width = -1; // Set through parent parameter.
    //global.__rt_height = -1; // Set through parent parameter.
    //global.__rt_aaLevel = -1; // Set through parent parameter.
    global.__rt_maxTraceDepth = 4;
    global.__rt_originx = 0;
    global.__rt_originy = 0;
    global.__rt_originz = 0;
    global.__rt_refractx = 0;
    global.__rt_refracty = 0;
    global.__rt_refractz = 0;
    global.__rt_p1x = 0;
    global.__rt_p1y = 0;
    global.__rt_p1z = 0;
    global.__rt_p2x = 0;
    global.__rt_p2y = 0;
    global.__rt_p2z = 0;
    global.__rt_p3x = 0;
    global.__rt_p3y = 0;
    global.__rt_p3z = 0;
    global.__rt_p4x = 0;
    global.__rt_p4y = 0;
    global.__rt_p4z = 0;
    global.__rt_dxx = 0;
    global.__rt_dxy = 0;
    global.__rt_dxz = 0;
    global.__rt_dyx = 0;
    global.__rt_dyy = 0;
    global.__rt_dyz = 0;
    
    // Colors:
    global.cl_colors = 0;
    global.cl_numColors = 0;
    
    // Lights:
    global.lt_lights = 0;
    global.lt_numLights = 0;
    
    // Materials:
    global.mat_materials = 0;
    global.mat_numMaterials = 0;
    
    // Matrices:
    global.mt_matrices = 0;
    global.mt_numMatrices = 0;
    
    // Shapes:
    global.__rt_shapes = 0;
    global.__rt_numShapes = 0;
    
    // Rays:
    //global.ry_px = 0;
    //global.ry_py = 0;
    //global.ry_pz = 0;
    //global.ry_dirx = 0;
    //global.ry_diry = 0;
    //global.ry_dirz = 0;
    global.ry_t = 0;
    global.ry_nx = 0;
    global.ry_ny = 0;
    global.ry_nz = 0;
    global.ry_r = 0;
    
    // Ray Trace (script?):
    global.__rt_visibility_limit = 3 / 255;
    //global.__rt_r = 0;
    //global.__rt_g = 0;
    //global.__rt_b = 0;
    
    // Threading:
    global.__rt_grid_color_r = ds_grid_create(global.__rt_width, global.__rt_height);
    global.__rt_grid_color_g = ds_grid_create(global.__rt_width, global.__rt_height);
    global.__rt_grid_color_b = ds_grid_create(global.__rt_width, global.__rt_height);
    global.__rt_grid_depth = ds_grid_create(global.__rt_width, global.__rt_height);
    global.__rt_exit_now = false;
    //global.__rt_list_color = ds_list_create();
    //global.__rt_list_depth = ds_list_create();
    
    // Render Smart AA:
    global.__rt_aa_color_limit = 3;
    
    // Render Depth of Field:
    global.__rt_dof_focus_depth = 50;
    global.__rt_dof_focus_scale = 1 / 125000;
}
