#define menu_background_padding
var _menu, _vpadding, _hpadding;
_menu = argument0;
_hpadding = argument1;
_vpadding = argument2;
ds_map_replace(_menu,"backgroundhpadding",_hpadding);
ds_map_replace(_menu,"backgroundvpadding",_vpadding);


#define menu_background
var _menu, _color, _alpha, _outline;
_menu = argument0;
_color = argument1;
_alpha = argument2;
_outline = argument3
if _outline
{
    ds_map_replace(_menu,"backgroundoutlinecolor",_color);
    ds_map_replace(_menu,"backgroundoutlinealpha",_alpha);
}
else
{
    ds_map_replace(_menu,"backgroundcolor",_color);
    ds_map_replace(_menu,"backgroundalpha",_alpha);
}

