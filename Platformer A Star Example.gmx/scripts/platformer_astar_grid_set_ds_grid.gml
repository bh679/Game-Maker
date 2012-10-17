//platformer_astar_grid_set_ds_grid(grd,ds_grid)
/*
**
**  grid = the cost grid being edited
**
**  ds_grid = the ds_grid being coppied from - values in this grid should be the terrain type+the cost.
**            eg. impassable ground would be 1999 as 1000 is ground and 999 indicates the ground is impassable.
**
*** Returns: Nothing
*/

var grd;

grd=ds_list_find_value(pas_lst_grids,argument0)

ds_grid_set_grid_region(grd,argument1,0,0,ds_grid_width(argument1),ds_grid_height(argument1),0,0)
