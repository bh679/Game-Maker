//platformer_astar_grid_get_cell_type(grd,x,y)
/*
**
**  grid = the cost grid being scanned
**
**  x/y = the position at which the terrain type is being gotten
**
*** Returns: The terrain type at the cell indicated - will be a multiple of 1000
***          see platformer_astar_start for a list of terrain types
*/

var grd;

grd=ds_list_find_value(pas_lst_grids,argument0)

return floor(ds_grid_get(grd,argument1,argument2)/1000)*1000
