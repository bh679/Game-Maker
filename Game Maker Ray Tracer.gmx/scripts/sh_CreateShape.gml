//argument0 - type
//argument1 - x
//argument2 - y
//argument3 - z
//argument4 to argument6
//SH_SPHERE
//  radius, 0, 0
//SH_PLANE
// normal x, normal y normal z
//argument7 - material
{
    global.__rt_shapes[global.__rt_numShapes, 0] = argument0;
    global.__rt_shapes[global.__rt_numShapes, 1] = argument1;
    global.__rt_shapes[global.__rt_numShapes, 2] = argument2;
    global.__rt_shapes[global.__rt_numShapes, 3] = argument3;
    global.__rt_shapes[global.__rt_numShapes, 4] = argument4;
    global.__rt_shapes[global.__rt_numShapes, 5] = argument5;
    global.__rt_shapes[global.__rt_numShapes, 6] = argument6;
    global.__rt_shapes[global.__rt_numShapes, 7] = argument7;
    global.__rt_numShapes += 1;
    return global.__rt_numShapes - 1;
}
