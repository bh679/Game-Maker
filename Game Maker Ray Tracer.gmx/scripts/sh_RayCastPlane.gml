{
    var t, dot1, dot2;
    dot1 = (argument0 - argument6) * argument9 + (argument1 - argument7) * argument10 + (argument2 - argument8) * argument11;
    dot2 = argument3 * argument9 + argument4 * argument10 + argument5 * argument11;
    if(dot2 == 0)
    {
        return false;
    }
    t = -dot1 /dot2;
    if(t < 0)
    {
        return false;
    }
    
    if(!global.shadow_test)
    {
        global.ry_t = t;
        global.ry_nx = argument9;
        global.ry_ny = argument10;
        global.ry_nz = argument11;
        global.ry_r = 1;
    }
    return true;
}
