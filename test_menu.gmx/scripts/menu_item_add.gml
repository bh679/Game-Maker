/*
agr0 = menu id
arg1 = menu item text
*/
var _menu, _menuitems, _value, _wpadding, _hpadding, _hoverpadding;
_menu = argument0;
_menuitems = ds_map_find_value(_menu,"items");
_value = argument1;
ds_list_add(_menuitems,_value);
//update padding
menu_padding_fit(_menu, _value)
//save
ds_map_replace(_menu,"items",_menuitems)
return _menu;
