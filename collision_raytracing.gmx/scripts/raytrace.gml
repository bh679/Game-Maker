var i, _x, _y;
for (i=1;i<argument2;i+=1)
{
_x=x+lengthdir_x(i,argument0)
_y=y+lengthdir_y(i,argument0)
if collision_point(_x,_y,argument1,1,1)
{
break;
}
}
off_x=_x
off_y=_y
return false;
