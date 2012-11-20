var _menu, _menuitems, _value,  _wpadding, _hpadding;
_menu = argument0;
_menuitems = ds_map_find_value(_menu,"items")
_value = argument1;
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_menufontsize = ds_map_find_value(_menu,"fontsize")
_wpadding = max(ds_map_find_value(_menu,"wpadding"),string_width(_value)*(_menufontsize/12) + _hoverpadding)
_hpadding = ds_map_find_value(_menu,"hpadding")
menu_padding(_menu,_wpadding,_hpadding)
ds_map_replace(_menu,"items",_menuitems)
