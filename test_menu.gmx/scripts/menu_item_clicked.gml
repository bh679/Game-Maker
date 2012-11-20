var _menu, _i, _itemval, _menuitems, _x, _y, _hpadding, _wpadding, _margin;
_menu = argument0;
_itemval  = argument1
_menuitems = ds_map_find_value(_menu,"items");
_i = ds_list_find_index(_menuitems,_itemval)
_x = ds_map_find_value(_menu,"x");
_y = ds_map_find_value(_menu,"y");
_hpadding = ds_map_find_value(_menu,'hpadding');
_wpadding = ds_map_find_value(_menu,'wpadding');
_margin = ds_map_find_value(_menu,'margin')
_halign = ds_map_find_value(_menu,"halign")
_headerpadding = ds_map_find_value(_menu,"headerpadding")
_itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i) + _headerpadding
_itemx = _x

_boxx1 = _itemx - _halign *_wpadding/2
_boxy1 = _itemy - _hpadding/2
_boxx2 = _itemx + _wpadding - _halign *_wpadding/2
_boxy2 = _itemy + _hpadding/2

if mouse_check_button_pressed(mb_left) && MouseInBox(_boxx1, _boxy1, _boxx2, _boxy2)  
    return true;
return false;
