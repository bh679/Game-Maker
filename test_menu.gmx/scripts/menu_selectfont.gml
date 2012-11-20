var _menu, _alpha, _color;
_menu = argument0;
_color = argument1;
_alpha = argument2;
ds_map_replace(_menu,"selectfontalpha",_alpha mod 1)
ds_map_replace(_menu,"selectfontcolor",_color)
