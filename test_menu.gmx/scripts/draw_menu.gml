var _selectboxalpha, _selectboxcolor, _selectfontalpha, _selectfontcolor, _fontalpha,
 _fontcolor, _x, _y, _i, _menu, _menuitems, _padding, _margin, _xhover, _hoverpadding,
 _itemy, _itemx, _itemtext, _menufont, _lastalpha, _lastcolor, _menusize,
 _header, _headeralpha, _headercolor, _headercolor, _headerhalign, _headerfont, _headerfontsize,
 _backgroundalpha, _backgroundcolor, _backgroundoutlinecolor, _backgroundoutlinealpha, _backgroundhpadding,
 _backgroundvpadding;
  
_menu = argument0

_lastalpha = draw_get_alpha()
_lastcolor = draw_get_color()

_x = ds_map_find_value(_menu,"x")
_y = ds_map_find_value(_menu,"y")
_hpadding = ds_map_find_value(_menu,'hpadding')
_wpadding = ds_map_find_value(_menu,'wpadding')
_margin = ds_map_find_value(_menu,'margin')
_menuitems = ds_map_find_value(_menu,"items")
_menusize = ds_list_size(_menuitems)
_headerpadding = ds_map_find_value(_menu,"headerpadding")

//background
_halign = ds_map_find_value(_menu,"halign")
_valign = ds_map_find_value(_menu,"valign")
_backgroundalpha = ds_map_find_value(_menu, "backgroundalpha")
_backgroundcolor = ds_map_find_value(_menu, "backgroundcolor")
_backgroundoutlinecolor = ds_map_find_value(_menu, "backgroundoutlinecolor")
_backgroundoutlinealpha = ds_map_find_value(_menu, "backgroundoutlinealpha")
_backgroundhpadding = ds_map_find_value(_menu, "backgroundhpadding")
_backgroundvpadding = ds_map_find_value(_menu, "backgroundvpadding")
if _backgroundalpha > 0 && _backgroundoutlinealpha > 0
{
    var _x1, _y1, _y2, _x2;
    _x1 = _x - (_wpadding)*(_halign)/2 - (_backgroundhpadding)*(2-_halign)/2
    _y1 = _y - _backgroundvpadding
    _y2 = _y + (_hpadding * (_menusize)) + (_margin * _menusize) + _headerpadding + _backgroundvpadding
    _x2 = _x + (_wpadding)*(2-_halign)/2 + (_backgroundhpadding)*(_halign)/2 
    draw_set_alpha(_backgroundalpha)
    draw_set_color(_backgroundcolor)
    draw_rectangle(_x1,_y1,_x2,_y2,false)
    draw_set_alpha(_backgroundoutlinealpha)
    draw_set_color(_backgroundoutlinecolor)
    draw_rectangle(_x1,_y1,_x2,_y2,true)
}

//menu haeder
_header = ds_map_find_value(_menu,"header")
_headeralpha = ds_map_find_value(_menu,"headerfontalpha")
_headercolor = ds_map_find_value(_menu,"headerfontcolor")
_headerhalign = ds_map_find_value(_menu,"headerhalign")
_headerfont = ds_map_find_value(_menu,"headerfont")
_headerfontsize = ds_map_find_value(_menu,"headerfontsize")

if _headerfont != -1
{
    if font_exists(_headerfont)
        draw_set_font(_headerfont)
}

draw_set_color(_headercolor)
draw_set_alpha(_headeralpha)
draw_set_halign(_headerhalign)
draw_set_halign(_headerhalign)
_itemy = _y + (_headerpadding * (0.5))
_itemx = _x
draw_text(_itemx, _itemy, string(_header));

//menu items
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_hoverpadding = ds_map_find_value(_menu,"hoverpadding")
_selectboxalpha = ds_map_find_value(_menu,"selectboxalpha")
_selectboxcolor = ds_map_find_value(_menu,"selectboxcolor")
_selectfontalpha = ds_map_find_value(_menu,"selectfontalpha")
_selectfontcolor = ds_map_find_value(_menu,"selectfontcolor")
_fontcolor = ds_map_find_value(_menu,"fontcolor")
_fontalpha = ds_map_find_value(_menu,"fontalpha")


//if os_type = os_windows || os_type = os_macosx
//{
_menufont = ds_map_find_value(_menu,"font")
if _menufont != -1
{
    if font_exists(_menufont)
        draw_set_font(_menufont)
}
//}
draw_set_halign(_halign)
draw_set_valign(_valign)
for(_i = 0; _i < _menusize; _i += 1)
{
    _itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i) + _headerpadding
    _itemx = _x
    _itemtext = ds_list_find_value(_menuitems,_i);
    _xhover = 0;
    draw_set_color(_fontcolor)
    draw_set_alpha(_fontalpha)
    _boxx1 = _itemx - _halign *_wpadding/2
    _boxy1 = _itemy - _hpadding/2
    _boxx2 = _itemx + _wpadding - _halign *_wpadding/2
    _boxy2 = _itemy + _hpadding/2
    if MouseInBox(_boxx1, _boxy1, _boxx2, _boxy2) 
    {
        _xhover = -_hoverpadding*(_halign-1)
        draw_set_alpha(_selectboxalpha)
        draw_set_color(_selectboxcolor)
        draw_rectangle(_boxx1, _boxy1, _boxx2, _boxy2, false) 
        draw_set_alpha(1)
        draw_set_color(_selectfontcolor)
        draw_set_alpha(_selectfontalpha)
    }
    draw_text(_itemx + _xhover /*+ _halign *_wpadding/2*/, _itemy, string(_itemtext));
}

draw_set_color(_lastcolor)
draw_set_alpha(_lastalpha)
