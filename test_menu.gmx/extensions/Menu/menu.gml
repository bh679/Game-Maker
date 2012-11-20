#define menu_new
//returns new menu with default values
var _menu, _menuitems, _menufontsize, _menufont;

//create
_menu = ds_map_create();

//items
_menuitems = ds_list_create();
ds_map_add(_menu,"items",_menuitems)

/////////////////
//style

//font
ds_map_add(_menu,"fontbold",false)
ds_map_add(_menu,"fontitalic",false)
_menufontsize = 24
_menufont = font_add("Trebuchet MS",_menufontsize,false,false,32,128)
ds_map_add(_menu,"font",_menufont)
ds_map_add(_menu,"fontsize",_menufontsize)
ds_map_add(_menu,"halign",fa_middle)
ds_map_add(_menu,"valign",fa_center)
ds_map_add(_menu,"fontcolor",c_black)
ds_map_add(_menu,"fontalpha",1)

//select box
ds_map_add(_menu,"selectboxalpha",0.1)
ds_map_add(_menu,"selectboxcolor",c_black)
ds_map_add(_menu,"selectfontcolor",c_black)
ds_map_add(_menu,"selectfontalpha",1)


//structure
ds_map_add(_menu,"hpadding",_menufontsize*2)
ds_map_add(_menu,"wpadding",10)
ds_map_add(_menu,"margin",0)
ds_map_add(_menu,"x",0)
ds_map_add(_menu,"y",0)
ds_map_add(_menu,"textcolor",c_black)
ds_map_add(_menu,"hoverpadding",10)

return _menu;

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

#define menu_align
var _menu, _valign, _halign;
_menu = argument0;
_halign = argument1;
_valign = argument2;

ds_map_replace(_menu,"valign",_valign);
ds_map_replace(_menu,"halign",_halign);

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

draw_set_color(_textcolor);
_xhover = 0;

//show_message(string(_itemtext) + " | length: " + string(string_length(_itemtext)) + " | width: " + string(string_width(_itemtext)))
if mouse_check_button_pressed(mb_left) && MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    return true;
return false;


#define menu_item_clicked
var _menu, _i;
_menu = argument0;

_itemval  = argument1
_menuitems = ds_map_find_value(_menu,"items");
_i = ds_list_find_index(_menuitems,_itemval)
show_debug_message(string(_i))

_x = ds_map_find_value(_menu,"x");
_y = ds_map_find_value(_menu,"y");
_hpadding = ds_map_find_value(_menu,'hpadding');
_wpadding = ds_map_find_value(_menu,'wpadding');
_margin = ds_map_find_value(_menu,'margin')

_itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i)
_itemx = _x

draw_set_color(_textcolor);
_xhover = 0;

//show_message(string(_itemtext) + " | length: " + string(string_length(_itemtext)) + " | width: " + string(string_width(_itemtext)))
if mouse_check_button_pressed(mb_left) && MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    return true;
return false;


#define menu_selectbox
var _menu, _alpha, _color;
_menu = argument0;
_color = argument1;
_alpha = argument2;

ds_map_replace(_menu,"selectboxalpha",_alpha mod 1)
ds_map_replace(_menu,"selectboxcolor",_color)

#define menu_selectfont
var _menu, _alpha, _color;
_menu = argument0;
_color = argument1;
_alpha = argument2;

ds_map_replace(_menu,"selectfontalpha",_alpha mod 1)
ds_map_replace(_menu,"selectfontolor",_color)

#define menu_font
var _menu, _color, _alpha;
_menu = argument0;
_color = argument1;
_alpha = argument2;

ds_map_replace(_menu,"fontcolor",_color)
ds_map_replace(_menu,"fontalpha",_alpha)

#define menu_position_set
var _menu, _x, _y;

_menu = argument0
_x = argument1
_y = argument2

ds_map_replace(_menu,"x",_x)
ds_map_replace(_menu,"y",_y)

return _menu

#define menu_padding
_menu = argument0;
_wpadding = argument1;
_hpadding = argument2;

ds_map_replace(_menu,"wpadding",_wpadding)
ds_map_replace(_menu,"hpadding",_hpadding)


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

#define draw_menu
var _fontcolor, _x, _y, _i, _menu, _menuitems, _padding, _margin, _xhover, _hoverpadding, _itemy, _itemx, _itemtext, _menufont;

_menu = argument0

_x = ds_map_find_value(_menu,"x")
_y = ds_map_find_value(_menu,"y")
_hpadding = ds_map_find_value(_menu,'hpadding')
_wpadding = ds_map_find_value(_menu,'wpadding')
_margin = ds_map_find_value(_menu,'margin')
_menuitems = ds_map_find_value(_menu,"items")
_textcolor = ds_map_find_value(_menu,"textcolor")
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_halign = ds_map_find_value(_menu,"halign")
_valign = ds_map_find_value(_menu,"valign")
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_selectboxalpha = ds_map_find_value(_menu,"selectboxalpha")
_selectboxcolor = ds_map_find_value(_menu,"selectboxcolor")
_fontcolor = ds_map_find_value(_menu,"fontcolor")
if os_type = os_windows || os_type = os_macosx
{
    _menufont = font0;//ds_map_find_value(_menu,"font")
    if font_exists(_menufont)
        draw_set_font(_menufont)
}

draw_set_halign(_halign)
draw_set_valign(_valign)

for(_i = 0; _i < ds_list_size(_menu); _i += 1)
{
    _itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i)
    _itemx = _x
    _itemtext = ds_list_find_value(_menuitems,_i);
    
    draw_set_color(_textcolor);
    _xhover = 0;
    
    if MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    {
        _xhover = -_hoverpadding*(_halign-1)
        draw_set_alpha(_selectboxalpha)
        draw_set_color(_selectboxcolor)
        draw_rectangle(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2,false) 
        draw_set_alpha(1)
    }
    draw_set_color(_fontcolor)
    draw_text(_itemx + _xhover + _halign *_wpadding/2, _itemy, string(_itemtext));
}

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

#define menu_get_size
var _manu;
_menu = argument0
return ds_list_size(_menu)



#define menu_get_selectbox_alpha
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"selectboxalpha")

#define menu_get_selectbox_color
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"selectboxcolor")

#define menu_get_halign
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"halign")

#define menu_get_valign
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"valign")

#define menu_get_x
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"x")

#define menu_get_y
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"y")

#define menu_get_fontcolor
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"fontcolor")

#define menu_get_fontalpha
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"fontalpha")

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

