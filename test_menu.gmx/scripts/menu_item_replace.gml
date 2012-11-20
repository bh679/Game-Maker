/*
agr0 = menu id
arg1 = menu item to replace
arg2 = menu item text
*/
var _menu, _menuitems, _value ,_repalcevalue, _pos, _hoverpadding, _wpadding, _hpadding;
_menu = argument0;
_menuitems = ds_map_find_value(_menu,"items")
_value = argument2
_repalcevalue  = argument1
_pos = ds_list_find_index(_menuitems,_repalcevalue)
ds_list_replace(_menuitems,_pos,_value)
//update padding
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_wpadding = max(ds_map_find_value(_menu,"wpadding"),string_width(_value) + _hoverpadding)
_hpadding = ds_map_find_value(_menu,"hpadding")
menu_padding(_menu,_wpadding,_hpadding)
ds_map_replace(_menu,"items",_menuitems)
return _menu
