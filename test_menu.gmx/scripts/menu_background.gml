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
