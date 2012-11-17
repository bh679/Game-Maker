{
    global.cl_colors[argument0, 0] = 0;
    global.cl_colors[argument0, 1] = 0;
    global.cl_colors[argument0, 2] = 0;
    if(argument0 == global.cl_numColors - 1) {
        global.cl_numColors -= 1;
        return true;
    }
    return false;
}