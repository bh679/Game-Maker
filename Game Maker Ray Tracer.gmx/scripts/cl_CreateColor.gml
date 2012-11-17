{
    global.cl_colors[global.cl_numColors, 0] = argument0;
    global.cl_colors[global.cl_numColors, 1] = argument1;
    global.cl_colors[global.cl_numColors, 2] = argument2;
    global.cl_numColors += 1;
    return global.cl_numColors - 1;
}