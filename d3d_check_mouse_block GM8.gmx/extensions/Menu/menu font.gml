#define menu_font
var _menu, _color, _alpha, _font;
_menu = argument0;
_font = argument1;
_color = argument2;
_alpha = argument3;

//font size
if _font != -1
{
    if font_exists(_font)
    {
        _fontsize = font_get_size(_font)
        ds_map_replace(_menu,"fontsize",_fontsize)
    }
}

ds_map_replace(_menu,"font",_font)
ds_map_replace(_menu,"fontcolor",_color)
ds_map_replace(_menu,"fontalpha",_alpha)

#define menu_get_valign
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"valign")

#define menu_get_halign
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"halign")

#define menu_get_fontcolor
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"fontcolor")

#define menu_get_font
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"font")

#define menu_get_fontalpha
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"fontalpha")

