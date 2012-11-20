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
