{
    /*
        Argument[0] = From X (left to right)
        Argument[1] = From Y (bottom to top)
        Argument[2] = From Z (front to back)
        Argument[3] = To X (left to right)
        Argument[4] = To Y (bottom to top)
        Argument[5] = To Z (front to back)
        Argument[6] = Up X (left to right)
        Argument[7] = Up Y (bottom to top)
        Argument[8] = Up Z (front to back)
    */
    
    var zx, zy, zz, xx, xy, xz, yx, yy, yz, l, m, i;
    zx = argument[3] - argument[0];
    zy = argument[4] - argument[1];
    zz = argument[5] - argument[2];
    l = sqrt(zx * zx + zy * zy + zz * zz);
    zx /= l;
    zy /= l;
    zz /= l;
    xx = argument[7] * zz - argument[8] * zy;
    xy = argument[8] * zx - argument[6] * zz;
    xz = argument[6] * zy - argument[7] * zx;
    yx = xy * -zz - xz * -zy;
    yy = xz * -zx - xx * -zz;
    yz = xx * -zy - xy * -zx;
    m = mt_CreateMatrix(xx, xy, xz, 0, yx, yy, yz, 0, zx, zy, zz, 0);
    mt_Invert(m);
    mt_SetValue(m, 3, argument[0]);
    mt_SetValue(m, 7, argument[1]);
    mt_SetValue(m, 11, argument[2]);
    mt_Transform(m, 0, 0, -5);
    global.__rt_originx = global.mt_x;
    global.__rt_originy = global.mt_y;
    global.__rt_originz = global.mt_z;
    mt_Transform(m, -4, 4, 0);
    global.__rt_p1x = global.mt_x;
    global.__rt_p1y = global.mt_y;
    global.__rt_p1z = global.mt_z;
    mt_Transform(m, 4, 4, 0);
    global.__rt_p2x = global.mt_x;
    global.__rt_p2y = global.mt_y;
    global.__rt_p2z = global.mt_z;
    mt_Transform(m, 4, -4, 0);
    global.__rt_p3x = global.mt_x;
    global.__rt_p3y = global.mt_y;
    global.__rt_p3z = global.mt_z;
    mt_Transform(m, -4, -4, 0);
    global.__rt_p4x = global.mt_x;
    global.__rt_p4y = global.mt_y;
    global.__rt_p4z = global.mt_z;
    global.__rt_dxx = (global.__rt_p2x - global.__rt_p1x) / global.__rt_width;
    global.__rt_dxy = (global.__rt_p2y - global.__rt_p1y) / global.__rt_width;
    global.__rt_dxz = (global.__rt_p2z - global.__rt_p1z) / global.__rt_width;
    global.__rt_dyx = (global.__rt_p4x - global.__rt_p1x) / global.__rt_height;
    global.__rt_dyy = (global.__rt_p4y - global.__rt_p1y) / global.__rt_height;
    global.__rt_dyz = (global.__rt_p4z - global.__rt_p1z) / global.__rt_height;
}
