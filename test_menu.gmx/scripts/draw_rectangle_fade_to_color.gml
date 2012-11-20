var _x1, _y1, _x2, _y2, _color, _alpha, _loops, _i, _xdis, _ydis, _xstep, _ystep;
_x1 = argument0
_y1 = argument1
_x2 = argument2
_y2 = argument3
_color = argument4
_alpha = argument5
draw_set_color(_color)
_xdis = abs(_x1 - _x2)
_ydis = abs(_y1 - _y2)
if _xdis > _ydis
{
    _loops = _xdis
    _xstep = 1
    _ystep = _ydis/_xdis
}else
{
    _loops = _ydis
    _ystep = 1
    _xstep = _xdis/_ydis
}
for(_i = 0; _i < _loops; _i += 1)
{
    draw_set_alpha(_alpha/(_loops))
    draw_rectangle(_x1 - _xstep*_i, _y1 - _ystep*_i, _x2 + _xstep*_i, _y2 + _ystep*_i,false)
}
