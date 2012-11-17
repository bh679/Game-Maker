{
    var spx, spy, spz, vd, des, sqrtdes, t, t1, t2, l;
    spx = argument0 - argument6;
    spy = argument1 - argument7;
    spz = argument2 - argument8;
    vd = spx * argument3 + spy * argument4 + spz * argument5;
    des = vd * vd - (spx * spx + spy * spy + spz * spz - argument9 * argument9);
    if(des < 0)
    {
        return false;
    }
    sqrtdes = sqrt(des);
    t1 = -vd + sqrtdes;
    t2 = -vd - sqrtdes;
    if(t1 < 0 && t2 < 0)
    {
        return false;
    }
    t = min(t1, t2);
    if(t1 < 0)
    {
        t = t2;
    }
    if(t2 < 0)
    {
        t = t1;
    }
    
    if(!global.shadow_test)
    {
        global.ry_t = t;
        global.ry_nx = spx + argument3 * global.ry_t;
        global.ry_ny = spy + argument4 * global.ry_t;
        global.ry_nz = spz + argument5 * global.ry_t;
        l = sqrt(global.ry_nx * global.ry_nx + global.ry_ny * global.ry_ny + global.ry_nz * global.ry_nz);
        global.ry_nx /= l;
        global.ry_ny /= l;
        global.ry_nz /= l;
        global.ry_r = 1;
        if(t1 < 0 || t2 < 0)
        {
            global.ry_r = -1;
        }
    }
    return true;
}
