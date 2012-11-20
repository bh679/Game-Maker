#define MouseInBox
var _x1, _y1, _x2, _y2;

_x1 = argument0
_y1 = argument1
_x2 = argument2
_y2 = argument3
/*
1----------------
|               |
|               |
----------------2
*/
if mouse_x > _x1 and mouse_x < _x2 and mouse_y > _y1 and mouse_y < _y2
    return true
//else
return false 

