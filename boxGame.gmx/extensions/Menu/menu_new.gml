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
_menufont = -1;//font_add("Trebuchet MS",_menufontsize,false,false,32,128)
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

//header
ds_map_add(_menu,"header","")
ds_map_add(_menu,"headeralpha",1)
ds_map_add(_menu,"headercolor",c_black)
ds_map_add(_menu,"headerhalign",fa_middle)
ds_map_add(_menu,"headerfont",_menufont)
ds_map_add(_menu,"headerfontsize",_menufontsize*2)
ds_map_add(_menu,"headerpadding",0)

//outline
ds_map_add(_menu,"backgroundalpha",0.1)
ds_map_add(_menu,"backgroundcolor",c_white)
ds_map_add(_menu,"backgroundoutlinealpha",0.4)
ds_map_add(_menu,"backgroundoutlinecolor",c_black)
ds_map_add(_menu,"backgroundhpadding",0)
ds_map_add(_menu,"backgroundvpadding",0)

//structure
ds_map_add(_menu,"hpadding",_menufontsize*2)
ds_map_add(_menu,"wpadding",10)
ds_map_add(_menu,"margin",0)
ds_map_add(_menu,"x",room_width/2)
ds_map_add(_menu,"y",0)
ds_map_add(_menu,"hoverpadding",10)
return _menu;

