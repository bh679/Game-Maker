#define menu_item_clicked
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


#define MouseInBox
var _x1, _y1, _x2, _y2;

_x1 = argument0
_y1 = argument1
_x2 = argument2
_y2 = argument3
/*
1----------------
|               |
|               |
----------------2
*/
if mouse_x > _x1 and mouse_x < _x2 and mouse_y > _y1 and mouse_y < _y2
    return true
//else
return false 

#define menu_item_clicked_pos
var _menu, _i;
_menu = argument0;
_i = argument1;

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


#define menu_item_add
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

#define menu_item_insert

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

#define menu_item_replace_pos

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

ds_list_replace(_menuitems,_pos,_value)

//update padding
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_wpadding = max(ds_map_find_value(_menu,"wpadding"),string_width(_value) + _hoverpadding)
_hpadding = ds_map_find_value(_menu,"hpadding")
menu_padding(_menu,_wpadding,_hpadding)

ds_map_replace(_menu,"items",_menuitems)
return _menu

#define menu_item_replace

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

#define menu_get_size
var _manu;
_menu = argument0
return ds_list_size(_menu)



#define menu_padding_fit
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

#define menu_padding
_menu = argument0;
_wpadding = argument1;
_hpadding = argument2;

ds_map_replace(_menu,"wpadding",_wpadding)
ds_map_replace(_menu,"hpadding",_hpadding)


