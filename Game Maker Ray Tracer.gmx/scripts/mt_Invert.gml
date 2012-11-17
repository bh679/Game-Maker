//argument0 - matrix to invert
{
    var m, t, tx, ty, tz, h, v, i;
    m = argument0;
    t = mt_CreateMatrix();
    tx = -mt_GetValue(m, 3);
    ty = -mt_GetValue(m, 7);
    tz = -mt_GetValue(m, 11);
    for(h = 0; h < 3; h += 1) {
        for(v = 0; v < 3; v += 1) {
            mt_SetValue(t, h + v * 4, mt_GetValue(m, v + h * 4));
        }
    }
    for(i = 0; i < 11; i += 1) {
        mt_SetValue(m, i, mt_GetValue(t, i));
    }
    mt_SetValue(m, 3, tx * mt_GetValue(m, 0) + ty * mt_GetValue(m, 1) + tz * mt_GetValue(m, 2));
    mt_SetValue(m, 7, tx * mt_GetValue(m, 4) + ty * mt_GetValue(m, 5) + tz * mt_GetValue(m, 6));
    mt_SetValue(m, 11, tx * mt_GetValue(m, 8) + ty * mt_GetValue(m, 9) + tz * mt_GetValue(m, 10));
}