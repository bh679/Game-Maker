#define menu_header_align
var _menu, _valign, _halign;
_menu = argument0;
_halign = argument1;
ds_map_replace(_menu,"headeralign",_halign);

#define menu_headerfont
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
        ds_map_replace(_menu,"headerfontsize",_fontsize)
    }
}
ds_map_replace(_menu,"headerfont",_font)
ds_map_replace(_menu,"headerfontcolor",_color)
ds_map_replace(_menu,"headerfontalpha",_alpha)

#define menu_header_padding
_menu = argument0;
_headerpadding = argument1;
ds_map_replace(_menu,"headerpadding",_headerpadding)

#define menu_get_header_font
var _menu;
_menu = argument0;
return ds_map_find_value(_menu,"headerfont")

