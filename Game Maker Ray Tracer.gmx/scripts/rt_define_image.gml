{
    // Make all changes for what to render in here!
    
    var material_polish, material_cyan, material_green, material_yellow, material_white, material_glass, material_mirror;
    
    // rt_look_at() arguments:
        // Argument[0] = From X (left to right)
        // Argument[1] = From Y (bottom to top)
        // Argument[2] = From Z (front to back)
        // Argument[3] = To X (left to right)
        // Argument[4] = To Y (bottom to top)
        // Argument[5] = To Z (front to back)
        // Argument[6] = Up X (left to right)
        // Argument[7] = Up Y (bottom to top)
        // Argument[8] = Up Z (front to back)
    rt_look_at(0, 0, -90, 0, 0, 0, 0, 1, 0);
    
    // mat_CreateMaterial() arguments:
        // Argument[0] = diffuse color
        // Argument[1] = specular color
        // Argument[2] = shininess
        // Argument[3] = reflective color
        // Argument[4] = refractive color
        // Argument[5] = refractive index (n > 1)
    material_polish = mat_CreateMaterial(cl_CreateColor(0.5, 0.5, 0.5),
                                         cl_CreateColor(0.3, 0.3, 0.3),
                                         5,
                                         cl_CreateColor(0.6, 0.6, 0.6),
                                         cl_CreateColor(0, 0, 0),
                                         1);
    material_cyan = mat_CreateMaterial(cl_CreateColor(0, 0.3, 1),
                                       cl_CreateColor(0.3, 0.3, 0.3),
                                       2,
                                       cl_CreateColor(0.1, 0.1, 0.1),
                                       cl_CreateColor(0, 0, 0),
                                       1);
    material_green = mat_CreateMaterial(cl_CreateColor(0, 1, 0),
                                        cl_CreateColor(0.1, 0.1, 0.1),
                                        10,
                                        cl_CreateColor(0, 0, 0),
                                        cl_CreateColor(0, 0, 0),
                                        1);
    material_yellow = mat_CreateMaterial(cl_CreateColor(1, 1, 0),
                                         cl_CreateColor(0.1, 0.1, 0.1),
                                         10,
                                         cl_CreateColor(0, 0, 0),
                                         cl_CreateColor(0, 0, 0),
                                         1);
    material_white = mat_CreateMaterial(cl_CreateColor(1, 1, 1.2),
                                        cl_CreateColor(0.01, 0.01, 0.01),
                                        10,
                                        cl_CreateColor(0, 0, 0),
                                        cl_CreateColor(0, 0, 0),
                                        1);
    material_glass = mat_CreateMaterial(cl_CreateColor(0.005, 0.010, 0.007),
                                        cl_CreateColor(1, 1, 1),
                                        50,
                                        cl_CreateColor(0.1, 0.1, 0.1),
                                        cl_CreateColor(0.85, 0.85, 0.85),
                                        1.5);
    material_mirror = mat_CreateMaterial(cl_CreateColor(0.1, 0.1, 0.1),
                                         cl_CreateColor(0.8, 0.8, 0.8),
                                         50,
                                         cl_CreateColor(0.85, 0.85, 0.85),
                                         cl_CreateColor(0, 0, 0),
                                         1);
    
    sh_CreateShape(SH_SPHERE, -60, 50, 70, 25, false, false, material_cyan);
    sh_CreateShape(SH_PLANE, 0, 100, 0, 0, -1, 0, material_white);
    sh_CreateShape(SH_PLANE, 100, 0, 0, -1, 0, 0, material_green);
    sh_CreateShape(SH_PLANE, -100, 0, 0, 1, 0, 0, material_yellow);
    sh_CreateShape(SH_PLANE, 0, 0, 100, 0, 0, -1, material_white);
    sh_CreateShape(SH_PLANE, 0, -100, 0, 0, 1, 0, material_white);
    sh_CreateShape(SH_PLANE, 0, 0, -100, 0, 0, 1, material_white);
    rt_make_sphereFlake(40, -30, 65, 40, material_polish);
    
    // Spot-lights for realistic high-lights:
    lt_CreateLight(LT_SPOT, -90, 90, -90, cl_CreateColor(120000, 120000, 120000), tan(degtorad(30)), -tan(degtorad(30)), tan(degtorad(30)), degtorad(30), degtorad(5));//, 10, 5);
    lt_CreateLight(LT_SPOT, 90, 90, -90, cl_CreateColor(120000, 120000, 120000), -tan(degtorad(30)), -tan(degtorad(30)), tan(degtorad(30)), degtorad(30), degtorad(5));//, 10, 5);
    
    // Point-light for ambient lighting:
    lt_CreateLight(LT_POINT, 0, 0, -80, cl_CreateColor(120000, 120000, 120000), false, false, false, false, false);//, 20, 10);
}
