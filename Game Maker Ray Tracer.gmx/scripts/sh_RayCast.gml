{
    if(global.__rt_shapes[argument6, 0] == SH_SPHERE)
    {
        return sh_RayCastSphere(argument0, argument1, argument2, argument3, argument4, argument5, global.__rt_shapes[argument6, 1], global.__rt_shapes[argument6, 2], global.__rt_shapes[argument6, 3], global.__rt_shapes[argument6, 4]);
    }
    if(global.__rt_shapes[argument6, 0] == SH_PLANE)
    {
        return sh_RayCastPlane(argument0, argument1, argument2, argument3, argument4, argument5, global.__rt_shapes[argument6, 1], global.__rt_shapes[argument6, 2], global.__rt_shapes[argument6, 3], global.__rt_shapes[argument6, 4], global.__rt_shapes[argument6, 5], global.__rt_shapes[argument6, 6]);
    }
}
