
/*
agr0 = menu id
arg1 = position in menu
arg2 = menu item text
*/

var _menu, _menuitems, _value, _pos, _hoverpadding, _wpadding, _hpadding;
_menu = argument0;
_menuitems = ds_map_find_value(_menu,"items")
_value = argument2
_pos  = argument1
ds_list_insert(_menuitems,_pos,_value)

//update padding
menu_padding_fit(_menu, _value)

ds_map_replace(_menu,"items",_menuitems)
return _menu
