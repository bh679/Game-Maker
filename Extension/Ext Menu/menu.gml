#define d3d_instance_nearest
var object, _x, _y, _z;
_x = argument0
_y = argument1
_z = argument2
object = argument3
global.nearest = noone
with(object)
{
    if global.nearest = noone
        global.nearest = id
    else if d3d_point_distance(_x,_y,_z,x,y,z) < d3d_point_distance(_x,_y,_z,global.nearest.x,global.nearest.y,global.nearest.z)
        global.nearest = id
}
return global.nearest

#define d3d_check_mouse_block
// d3d_check_mouse_block(x1,y1,z1,x2,y2,z2)

// Returns which side of the given 3D block the cursor is touching.
//      0       Not touching
//      1       Touching the east side (X)
//      2       Touching the west side (-X)
//      3       Touching the south side (Y)
//      4       Touching the north side (-Y)
//      5       Touching the top (Z)
//      6       Touching the bottom (-Z)

// Written by Davve
//    www.stuffbydavid.com

var x1,y1,z1,x2,y2,z2;
var a,b,c,l,w,h,px,py,pz,tx,ty,mx,my;
var px2d,py2d,px3d,py3d,pz3d;

x1=argument0
y1=argument1
z1=argument2
x2=argument3
y2=argument4
z2=argument5

mx=mouse_x
my=mouse_y

if (x2<x1) {a=x2; x2=x1; x1=a}
if (y2<y1) {a=y2; y2=y1; y1=a}
if (z2<z1) {a=z2; z2=z1; z1=a}

l=x2-x1
w=y2-y1
h=z2-z1

for (a=0 a<8 a+=1) {
    px3d[a]=x1+(a mod 2)*l
    py3d[a]=y1+((a div 2) mod 2)*w
    pz3d[a]=z1+(a div 4)*h
    
    px=px3d[a]-_xf
    py=py3d[a]-_yf
    pz=pz3d[a]-_zf
    
    b=max(0.001,px*_dx+py*_dy+pz*_dz)
    px/=b
    py/=b
    pz/=b
    
    b=tan(_a*pi/360)
    c=(px*_vx+py*_vy+pz*_vz)/sqr((view_wview[_v]/view_hview[_v])*b)
    px2d[a]=(c+1)/2*view_wview[_v]
    c=(px*_ux+py*_uy+pz*_uz)/sqr(b)
    py2d[a]=(1-c)/2*view_hview[_v]
}

for (a=0 a<6 a+=1) {
    if (a=0) {
        if (_xf<x1+l) continue
        for (b=0 b<4 b+=1) {tx[b]=px2d[(b+1)*2-1]; ty[b]=py2d[(b+1)*2-1]}
    }
    if (a=1) {
        if (_xf>x1) continue
        for (b=0 b<4 b+=1) {tx[b]=px2d[b*2]; ty[b]=py2d[b*2]}
    }
    if (a=2) {
        if (_yf<y1+w) continue
        for (b=0 b<4 b+=1) {tx[b]=px2d[b+2+2*(b>1)]; ty[b]=py2d[b+2+2*(b>1)]}
    }
    if (a=3) {
        if (_yf>y1) continue
        for (b=0 b<4 b+=1) {tx[b]=px2d[b+2*(b>1)]; ty[b]=py2d[b+2*(b>1)]}
    }
    if (a=4) {
        if (_zf<z1+h) continue
        for (b=0 b<4 b+=1) {tx[b]=px2d[b+4]; ty[b]=py2d[b+4]}
    }
    if (a=5) {
        if (_zf>z1) continue
        for (b=0 b<4 b+=1) {tx[b]=px2d[b]; ty[b]=py2d[b]}
    }
    
    b = sign((tx[0]-mx)*(ty[1]-my)-(tx[1]-mx)*(ty[0]-my))
      + sign((tx[1]-mx)*(ty[2]-my)-(tx[2]-mx)*(ty[1]-my))
      + sign((tx[2]-mx)*(ty[0]-my)-(tx[0]-mx)*(ty[2]-my))
    c = sign((tx[1]-mx)*(ty[2]-my)-(tx[2]-mx)*(ty[1]-my))
      + sign((tx[2]-mx)*(ty[3]-my)-(tx[3]-mx)*(ty[2]-my))
      + sign((tx[3]-mx)*(ty[1]-my)-(tx[1]-mx)*(ty[3]-my))
    if (abs(b)=3 || abs(c)=3) return a+1
}

return 0

#define d3d_check_mouse_block_prepare
// d3d_check_mouse_block_prepare(xfrom,yfrom,zfrom,xto,yto,zto,xup,yup,zup,angle,view)

// Call this script once before using d3d_check_mouse_block. It uses the same arguments
// as d3d_set_projection_ext, which the exception of the three last arguments.
// view indicates the current view you are using.

// Written by Yourself,
// modified by Davve
//    www.stuffbydavid.com

var a;

_xf=argument0
_yf=argument1
_zf=argument2
_a=argument9
_v=argument10

_dx=argument3-_xf
_dy=argument4-_yf
_dz=argument5-_zf

a=sqrt(_dx*_dx+_dy*_dy+_dz*_dz)
_dx/=a
_dy/=a
_dz/=a

a=argument6*_dx+argument7*_dy+argument8*_dz
_ux=argument6-a*_dx
_uy=argument7-a*_dy
_uz=argument8-a*_dz

a=sqrt(_ux*_ux+_uy*_uy+_uz*_uz)
_ux/=a
_uy/=a
_uz/=a

a=tan(_a*pi/360)
_ux*=a
_uy*=a
_uz*=a

_vx=(_uy*_dz-_uz*_dy)*(view_wview[_v]/view_hview[_v])
_vy=(_uz*_dx-_ux*_dz)*(view_wview[_v]/view_hview[_v])
_vz=(_ux*_dy-_uy*_dx)*(view_wview[_v]/view_hview[_v])

#define d3d_point_distance
px = argument0
py = argument1
pz = argument2
vx = argument3
vy = argument4
vz = argument5
return sqr((px-vx)*(px-vx)+(py-vy)*(py-vy)+(pz-vz)*(pz-vz))

#define point_blockdistance_3d
px = argument0
py = argument1
pz = argument2
vx = argument3
vy = argument4
vz = argument5
return (abs(px-vx)+abs(py-vy)+abs(pz-vz))

#define d3d_object_distance
object1 = argument0
object2 = argument1
return d3d_point_distance(object1.x,object1.y,object1.z,object2.x,object2.y,object2.z)

#define d3d_closest_to_camera
object1 = argument0
object2 = argument1


if object1 = noone
   return object2
   
if object2 = noone
   return object1
   
if (d3d_point_distance(obj_camera.xfrom,obj_camera.yfrom,obj_camera.zfrom,object1.x,object1.y,object1.z)) < (d3d_point_distance(obj_camera.xfrom,obj_camera.yfrom,obj_camera.zfrom,object2.x,object2.y,object2.z))
   return object1
return object2

#define draw_rectangle_fade_to_color
var _x1, _y1, _x2, _y2, _color, _alpha, _loops, _i, _xdis, _ydis, _xstep, _ystep;
_x1 = argument0
_y1 = argument1
_x2 = argument2
_y2 = argument3
_color = argument4
_alpha = argument5


draw_set_color(_color)
_xdis = abs(_x1 - _x2)
_ydis = abs(_y1 - _y2)

if _xdis > _ydis
{
    _loops = _xdis
    _xstep = 1
    _ystep = _ydis/_xdis
}else
{
    _loops = _ydis
    _ystep = 1
    _xstep = _xdis/_ydis
}

for(_i = 0; _i < _loops; _i += 1)
{
    draw_set_alpha(_alpha/(_loops))
    draw_rectangle(_x1 - _xstep*_i, _y1 - _ystep*_i, _x2 + _xstep*_i, _y2 + _ystep*_i,false)
}

#define calcOptBlocks
var blocks, targetdis;
blocks = 0
for(i = 0; i < targets; i += 1)
    targetdis[i] = 0
repeat(2)
{
    for(i = 0; i < targets; i += 1)
    {
        shortestDis = point_blockdistance_3d(0,0,0,targetx[i]*blocksize,targety[i]*blocksize,targetz[i]*blocksize)
        for(s = 0; s < targets; s += 1)
        {
            if targetdis[s] > 0
            {
                sdis = 
                    ceil(point_blockdistance_3d(targetx[s]*blocksize,targety[s]*blocksize,targetz[s]*blocksize,
                    targetx[i]*blocksize,targety[i]*blocksize,targetz[i]*blocksize))
                if shortestDis = 0 || shortestDis > sdis
                    shortestDis = sdis
            }
        }
        
        targetdis[i] = ceil((shortestDis+1/2)/blocksize)
        //show_message(string(blocks))
    }
}
for(i = 0; i < targets; i += 1)
    blocks += targetdis[i]
    
return blocks;

#define menu_align
var _menu, _valign, _halign;
_menu = argument0;
_halign = argument1;
_valign = argument2;

ds_map_replace(_menu,"valign",_valign);
ds_map_replace(_menu,"halign",_halign);

#define menu_position
var _menu, _x, _y;

_menu = argument0
_x = argument1
_y = argument2

ds_map_replace(_menu,"x",_x)
ds_map_replace(_menu,"y",_y)

return _menu

#define menu_margin
var _menu, _margin;

_menu = argument0
_margin = argument1

ds_map_replace(_menu,"margin",_margin)

return _menu

#define menu_get_x
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"x")

#define menu_get_y
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"y")

#define menu_hoverpadding
_menu = argument0;
_padding = argument1;

ds_map_replace(_menu,"hoverpadding",_padding)


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

#define menu_item_clicked
var _menu, _i;
_menu = argument0;

_itemval  = argument1
_menuitems = ds_map_find_value(_menu,"items");
_i = ds_list_find_index(_menuitems,_itemval)

_x = ds_map_find_value(_menu,"x");
_y = ds_map_find_value(_menu,"y");
_hpadding = ds_map_find_value(_menu,'hpadding');
_wpadding = ds_map_find_value(_menu,'wpadding');
_margin = ds_map_find_value(_menu,'margin')

_itemy = _y + (_hpadding * (_i+0.5)) + (_margin * _i)
_itemx = _x

if mouse_check_button_pressed(mb_left) && MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    return true;
return false;


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

if mouse_check_button_pressed(mb_left) && MouseInBox(_itemx, _itemy - _hpadding/2, _itemx + _wpadding, _itemy + _hpadding/2) 
    return true;
return false;


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

#define menu_get_size
var _manu;
_menu = argument0
return ds_list_size(_menu)



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

#define menu_padding
_menu = argument0;
_wpadding = argument1;
_hpadding = argument2;

ds_map_replace(_menu,"wpadding",_wpadding)
ds_map_replace(_menu,"hpadding",_hpadding)


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

#define menu_get_selectbox_alpha
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"selectboxalpha")

#define menu_get_selectbox_color
var _menu;
_menu = argument0;

return ds_map_find_value(_menu,"selectboxcolor")

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


//structure
ds_map_add(_menu,"hpadding",_menufontsize*2)
ds_map_add(_menu,"wpadding",10)
ds_map_add(_menu,"margin",0)
ds_map_add(_menu,"x",0)
ds_map_add(_menu,"y",0)
ds_map_add(_menu,"hoverpadding",10)

return _menu;

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

