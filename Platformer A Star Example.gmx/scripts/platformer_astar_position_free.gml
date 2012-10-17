//platformer_astar_position_free(x,y)
//Returns if the Astar character can fit where indicated - ony for the script: platformer_astar_movement
//x&y are relative as shown below
if pas_px>=0
{
    argument0+=pas_px
    argument1+=pas_py
}


var i;

for (i=argument1;i>argument1-pas_height;i-=1)
{
    if ds_grid_get(pas_grid,argument0,i) mod 1000 >=999
    return false
}

return true
