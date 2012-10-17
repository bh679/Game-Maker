//platformer_astar_grid_clear(grd,type,cost)
//clears the entire grid to the chosen value
/*
**
**  grid = the cost grid being edited
**
**  type = the terrain type - eg. pas_air,pas_ground,pas_water,pas_ladder,pas_platform,pas_danger
**         see platformer_astar_start for the terrain types
**
**  cost = the cost from 0 to 999.999 of moving to the cell, 999+ is concidered impassable. 1 is normal.
**         0 can have undisirable results under most circumstances - such as the ai allways jumping if bellow the goal.
**         This is because the ai like to be close to their goal, and they exert no energy in going near it of the cost is 0.
**
*** Returns: Nothing
*/

var grd;

grd=ds_list_find_value(pas_lst_grids,argument0)

ds_grid_clear(grd,argument1+median(0,999.999,argument2))
