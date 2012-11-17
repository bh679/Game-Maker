{
    var m;
    m = argument0;
    global.mt_x  = mt_GetValue(m, 0) * argument1 + mt_GetValue(m, 1) * argument2 + mt_GetValue(m, 2) * argument3 + mt_GetValue(m, 3);
    global.mt_y  = mt_GetValue(m, 4) * argument1 + mt_GetValue(m, 5) * argument2 + mt_GetValue(m, 6) * argument3 + mt_GetValue(m, 7);
    global.mt_z  = mt_GetValue(m, 8) * argument1 + mt_GetValue(m, 9) * argument2 + mt_GetValue(m, 10) * argument3 + mt_GetValue(m, 11);
}