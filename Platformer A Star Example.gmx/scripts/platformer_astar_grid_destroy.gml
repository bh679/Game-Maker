//platformer_astar_grid_destroy(grid)
//all grids are automatically destroyed when you call platformer_astar_end - you can destroy them
//earlier if you want though.
/*
**
**  grid = the grid created in platformer_astar_grid_create that you want to destroy.
**
*** Returns: Nothing
*/

ds_grid_destroy(ds_list_find_value(lst_grids,argument0))
ds_list_delete(lst_grids,argument0)
