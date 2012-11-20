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
