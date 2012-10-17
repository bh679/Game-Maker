//platformer_astar_grid_set_cell(grd,x,y,type,cost)
/*
**
**  grid = the cost grid being edited
**
**  x/y = the position at which the terrain and cost are being set
**
**  type = the terrain type - eg. pas_air,pas_ground,pas_water,pas_ladder,pas_platform,pas_danger
**         see platformer_astar_start for the terrain types
**
**  cost = the cost from 0 to 999.999 of moving to the cell, 999+ is concidered impassable. 1 is normal.
**         0 can have undisirable results under most circumstances - such as the ai allways jumping
**         if the ai is bellow the goal.
**
*** Returns: Nothing
*/

var grd;

grd=ds_list_find_value(pas_lst_grids,argument0)

ds_grid_set(grd,argument1,argument2,argument3+median(0,999.999,argument4))
