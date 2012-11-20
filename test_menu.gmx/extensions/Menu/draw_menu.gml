#define draw_menu
var _selectboxalpha, _selectboxcolor, _selectfontalpha, _selectfontcolor, _fontalpha,
 _fontcolor, _x, _y, _i, _menu, _menuitems, _padding, _margin, _xhover, _hoverpadding,
  _itemy, _itemx, _itemtext, _menufont;

_menu = argument0

_x = ds_map_find_value(_menu,"x")
_y = ds_map_find_value(_menu,"y")
_hpadding = ds_map_find_value(_menu,'hpadding')
_wpadding = ds_map_find_value(_menu,'wpadding')
_margin = ds_map_find_value(_menu,'margin')
_menuitems = ds_map_find_value(_menu,"items")
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_halign = ds_map_find_value(_menu,"halign")
_valign = ds_map_find_value(_menu,"valign")
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_selectboxalpha = ds_map_find_value(_menu,"selectboxalpha")
_selectboxcolor = ds_map_find_value(_menu,"selectboxcolor")
_selectfontalpha = ds_map_find_value(_menu,"selectfontalpha")
_selectfontcolor = ds_map_find_value(_menu,"selectfontcolor")
_fontcolor = ds_map_find_value(_menu,"fontcolor")
_fontalpha = ds_map_find_value(_menu,"fontalpha")
if os_type = os_windows || os_type = os_macosx
{
    
    _menufont = ds_map_find_value(_menu,"font")
    if _menufont != -1
    {
        if font_exists(_menufont)
            draw_set_font(_menufont)
    }
}


draw_set_halign(_halign)
draw_set_valign(_valign)

for(_i = 0; _i < ds_list_size(_menu); _i += 1)
{
    _itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i)
    _itemx = _x
    _itemtext = ds_list_find_value(_menuitems,_i);
    
    _xhover = 0;
    
    draw_set_color(_fontcolor)
    draw_set_alpha(_fontalpha)
    if MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    {
        _xhover = -_hoverpadding*(_halign-1)
        draw_set_alpha(_selectboxalpha)
        draw_set_color(_selectboxcolor)
        draw_rectangle(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2,false) 
        draw_set_alpha(1)
        draw_set_color(_selectfontcolor)
        draw_set_alpha(_selectfontalpha)
    }
    draw_text(_itemx + _xhover + _halign *_wpadding/2, _itemy, string(_itemtext));
}

