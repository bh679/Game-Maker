//platformer_astar_end()
//called to clean up - windows cleans up for you when the game ends anyway, but it's good practice.
/*
*** Returns: Nothing
*/

var i;

for (i=0;i<ds_list_size(pas_lst_grids);i+=1)
ds_grid_destroy(ds_list_find_value(pas_lst_grids,i))

ds_priority_destroy(pas_pri_open)
ds_map_destroy(pas_map_closed)
ds_map_destroy(pas_map_open)
ds_list_destroy(pas_lst_x)
ds_list_destroy(pas_lst_y)
ds_list_destroy(pas_lst_px)
ds_list_destroy(pas_lst_py)
ds_list_destroy(pas_lst_cst)
ds_list_destroy(pas_lst_grids)
ds_list_destroy(pas_lst_fall)
