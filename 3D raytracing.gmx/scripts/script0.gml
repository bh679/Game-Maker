/*
Args:
0 = angle at which the ray is running (real)
1 = object the ray is seeking (object name)
2 = maximum distance the ray will travel (real)
3 = chunk size. The length of lines the ray is divided (real)
*/

var i, a, _x, _y, _x2, _y2;

_x2=x
_y2=y

if collision_point(x,y,argument1,1,1)
{
off_x=x
off_y=y
exit;
}

for (i=1;i<argument2;i+=argument3)
{
_x=x+lengthdir_x(i,argument0)
_y=y+lengthdir_y(i,argument0)
if collision_line(_x2,_y2,_x,_y,argument1,1,1)
{
for (a=i-argument3;a<argument2;a+=1)
{
_x=x+lengthdir_x(a,argument0)
_y=y+lengthdir_y(a,argument0)
if collision_point(_x,_y,argument1,1,1)
{
off_x=_x
off_y=_y
return true;
exit;
}
}
}
_x2=_x
_y2=_y
}
off_x=_x
off_y=_y
return false;
