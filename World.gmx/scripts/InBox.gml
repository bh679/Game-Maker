var _x, _y, _x1, _x2, _y1, _y2;

_x = argument0
_y = argument1

_xbig = max(argument2,argument4)
_ybig = max(argument3,argument5)

_xsmall = min(argument2,argument4)
_ysmall = min(argument3,argument5)


if _x < _xbig and _x > _xsmall and _y < _ybig  and _y > _ysmall
    return true
return false

