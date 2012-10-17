//platformer_astar_get_fly_height(x,y)
//Used within platformer_astar_add_cell to calculate fear of heights
//x&y are absolute

var i;

for (i=argument1;i<ds_grid_height(pas_grid);i+=1)
switch floor(ds_grid_get(pas_grid,argument0,i)/1000)*1000
{
    //all cells that can be landed on
    case pas_ground:
    case pas_ladder:
    case pas_water:
    case pas_platform:
    case pas_danger:
        return i-argument1
    break;
}

return ds_grid_height(pas_grid)-argument1
