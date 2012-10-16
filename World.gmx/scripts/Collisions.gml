if (collision_line(x,y,x+lengthdir_x(speed,direction),y+lengthdir_y(speed,direction),obj_tree,1,0))
{
    tree = instance_nearest(x,y,obj_tree)
    direction = point_direction(x,y,tree.x,tree.y)
    x -= lengthdir_x(speed*2,direction)
    y -= lengthdir_y(speed*2,direction)
    newTarget()
}
