//platformer_astar_grid_set_region(grd,x2,y2,x2,y2,type,cost)
/*
**
**  grid = the cost grid being edited
**
**  x1/y1/x2/y2 = the region in which the terrain and cost are being set
**
**  type = the terrain type - eg. pas_air,pas_ground,pas_water,pas_ladder,pas_platform,pas_danger
**         see platformer_astar_start for the terrain types
**
**  cost = the cost from 0 to 999.999 of moving to the cell, 999+ is concidered impassable. 1 is normal.
**         0 can have undisirable results under most circumstances - such as the ai allways jumping if bellow the goal.
**
*** Returns: Nothing
*/

var grd;

grd=ds_list_find_value(pas_lst_grids,argument0)

ds_grid_set_region(grd,argument1,argument2,argument3,argument4,argument5+median(0,999.999,argument6))
