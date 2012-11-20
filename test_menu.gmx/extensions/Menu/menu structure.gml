#define menu_align
var _menu, _valign, _halign;
_menu = argument0;
_halign = argument1;
_valign = argument2;

ds_map_replace(_menu,"valign",_valign);
ds_map_replace(_menu,"halign",_halign);

#define menu_position
var _menu, _x, _y;

_menu = argument0
_x = argument1
_y = argument2

ds_map_replace(_menu,"x",_x)
ds_map_replace(_menu,"y",_y)

return _menu

#define menu_get_x
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"x")

#define menu_get_y
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"y")

#define menu_hoverpadding
_menu = argument0;
_padding = argument1;

ds_map_replace(_menu,"hoverpadding",_padding)


#define menu_get_hoverpadding
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"hoverpadding")

#define menu_get_margin
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"margin")

#define menu_get_vpadding
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"vpadding")

#define menu_get_hpadding
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"hpadding")

