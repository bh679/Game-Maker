targetx = argument0
targety = argument1
var _range;

if argument1 = 0 and argument0 != 0
    _range = argument0
else
    _range = walkToRange

if argument0=0
{
    targetx = x + random(_range)*2 - _range
    targety = y + random(_range)*2 - _range 
    if targetx < 0 or targetx > room_width
        targetx *= -1
    if targety < 0 or targety > room_height
        targety *= -1
}

speed = WALKspeed
direction = point_direction(x,y,targetx,targety)
