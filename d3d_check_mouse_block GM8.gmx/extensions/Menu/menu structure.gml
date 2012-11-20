#define menu_align
var _menu, _valign, _halign;
_menu = argument0;
_halign = argument1;
_valign = argument2;
ds_map_replace(_menu,"valign",_valign);
ds_map_replace(_menu,"halign",_halign);
ds_map_replace(_menu,"headerhalign",_halign);

#define menu_position
var _menu, _x, _y;
_menu = argument0
_x = argument1
_y = argument2
ds_map_replace(_menu,"x",_x)
ds_map_replace(_menu,"y",_y)
return _menu

#define menu_hoverpadding
_menu = argument0;
_padding = argument1;
ds_map_replace(_menu,"hoverpadding",_padding)

