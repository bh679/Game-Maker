//platformer_astar_get_touching_type(x,y,type)
//Returns if the Astar character is touching the terrain type - ony for the script: platformer_astar_movement
//x&y are relative as shown below
if pas_px>=0
{
    argument0+=pas_px
    argument1+=pas_py
}


var i;

for (i=argument1;i>argument1-pas_height;i-=1)
if floor(ds_grid_get(pas_grid,argument0,i)/1000)*1000=argument2
return true

return false
