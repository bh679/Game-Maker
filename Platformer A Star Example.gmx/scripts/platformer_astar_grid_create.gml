//platformer_astar_grid_create(w,h)
// Filled with air by default.
/*
**
**  w/h = the width and height of the grid in cells - the grid will be cleared to air with a cost of 1.
**        these are not ds_grids - don't treat them as ds_grids - they are list positions that refer to
**        ds_grids (so that platformer_astar_end can clean them all up).
**        If you need to use ds_grid functions on them - use this code to get the grid's id:
**        grid_id = ds_list_find_value(pas_lst_grids,list_id)
**
*** Returns: Nothing
*/


var grd;
grd=ds_grid_create(argument0,argument1)
ds_grid_clear(grd,pas_air+1)

ds_list_add(pas_lst_grids,grd)

return ds_list_size(pas_lst_grids)-1
