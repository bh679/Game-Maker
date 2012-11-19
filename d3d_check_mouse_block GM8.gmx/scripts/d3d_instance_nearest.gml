var object, _x, _y, _z;
_x = argument0
_y = argument1
_z = argument2
object = argument3
global.nearest = noone
with(object)
{
    if global.nearest = noone
        global.nearest = id
    else if d3d_point_distance(_x,_y,_z,x,y,z) < d3d_point_distance(_x,_y,_z,global.nearest.x,global.nearest.y,global.nearest.z)
        global.nearest = id
}
return global.nearest
