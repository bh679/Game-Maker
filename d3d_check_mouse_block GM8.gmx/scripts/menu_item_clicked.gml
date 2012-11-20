var _menu, _i;
_menu = argument0;

_itemval  = argument1
_menuitems = ds_map_find_value(_menu,"items");
_i = ds_list_find_index(_menuitems,_itemval)

_x = ds_map_find_value(_menu,"x");
_y = ds_map_find_value(_menu,"y");
_hpadding = ds_map_find_value(_menu,'hpadding');
_wpadding = ds_map_find_value(_menu,'wpadding');
_margin = ds_map_find_value(_menu,'margin')

_itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i)
_itemx = _x

if mouse_check_button_pressed(mb_left) && MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    return true;
return false;

