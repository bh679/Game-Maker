//platformer_astar_grid_get_cell_cost(grd,x,y)
//cost is how much the ai dislikes a cell - the ai preferences walking through low cost cells.
/*
**
**  grid = the cost grid being scanned
**
**  x/y = the position at which the cost of movement is being gotten
**
*** Returns: The cost of the cell indicated - will be from 0 to 999.999
***          if the cost is 999 or larger then the cell is impassable
*/

var grd;

grd=ds_list_find_value(pas_lst_grids,argument0)

return ds_grid_get(grd,argument1,argument2) mod 1000
