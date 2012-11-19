
bodya = point_direction(headx,heady,bodyx+lengthdir_x(38,bodya),bodyy+lengthdir_y(38,bodya))
dis = point_distance(headx,heady,bodyx+lengthdir_x(38,bodya),bodyy+lengthdir_y(38,bodya))/2

//back wing
draw_sprite_ext(spr_dragonwings,wingdex,bodyx,bodyy,-bodyimage_xscale*4/5*wingscale,wingscale,0,COLOR,1)

draw_set_color(c_black)
draw_set_alpha(1)

dir = (point_direction(lastx[0],lasty[0],lastx[TAILS-1],lasty[TAILS-1]) mod 360)
xtaillength = point_distance(lastx[0],0,lastx[TAILS-1],0)   //lastx[TAILS-1]-lastx[0]
ytaillength = point_distance(0,lasty[0],0,lasty[TAILS-1])  //lasty[TAILS-1]-lasty[0]  
xsinrate = (TAILSIZE-xtaillength)/(TAILSIZE/15)
ysinrate = (TAILSIZE-ytaillength)/(TAILSIZE/15)
c -= (xtaillength/TAILSIZE)+0.1;

//tail
for(i = TAILS-1; i >= 0; i -= 1)
{
    if (dir < 360 and dir > 270) or (dir < 180 and dir > 90)
    {
        tailx[i] = lastx[i]+sin(i/3+c)*xsinrate*(i/TAILS)
        taily[i] = lasty[i]-sin(i/3+c)*ysinrate*(i/TAILS)
    }
    else
    {
        tailx[i] = lastx[i]+sin(i/3+c)*xsinrate*(i/TAILS)
        taily[i] = lasty[i]+sin(i/3+c)*ysinrate*(i/TAILS)
    }
    draw_sprite_ext(spr_dragonneck,1,tailx[i],taily[i],0.9,1.5-i/12,taila[i],COLOR,1)
}

//neck
for(i = NECKS-1; i >= 0; i -= 1)
{
    if i = 0
    {
        neckx[0] = x + lengthdir_x(NECKSIZE*i/NECKS*(dis/NECKSIZE),bodya)
        necky[0] = y + lengthdir_y(NECKSIZE*i/NECKS*(dis/NECKSIZE),bodya)
    }
    else
    {
        newx = x + lengthdir_x(NECKSIZE*i/NECKS*(dis/NECKSIZE),bodya)
        newy = y + lengthdir_y(NECKSIZE*i/NECKS*(dis/NECKSIZE),bodya)
        neckx[i] = (NECKS-i)*neckx[i-1]/NECKS+i*newx/NECKS
        necky[i] = (NECKS-i)*necky[i-1]/NECKS+i*newy/NECKS
   // necka[i] = bodya
   }
    draw_sprite_ext(spr_dragonneck,1,neckx[i],necky[i],0.9,0.4+i/NECKS,necka[i],COLOR,1)
}

draw_sprite_ext(spr_dragonbody,1,bodyx,bodyy,1,bodyimage_xscale,bodya,COLOR,1)


//Legs
lega = bodya - bodyxspeed*10
legx = bodyx + lengthdir_x(10,bodya-30*bodyimage_xscale)//*bodyimage_xscale
legy = bodyy + lengthdir_y(10,bodya-30*bodyimage_xscale)//*bodyimage_xscale

draw_sprite_ext(spr_dragonleg,1,legx,legy,1,bodyimage_xscale,lega,COLOR,1)

//front wing
draw_sprite_ext(spr_dragonwings,wingdex,bodyx,bodyy,bodyimage_xscale*wingscale,wingscale,0,COLOR,1)

with(obj_fire)
    {draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,direction,image_blend,image_alpha)}

draw_sprite_ext(spr_dragonhead,headindex,headx,heady,1,-image_xscale,heada,COLOR,1)
