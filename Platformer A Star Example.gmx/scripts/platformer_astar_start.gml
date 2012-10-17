//platformer_astar_start()
//Must be called first!
//
//If you are adding your own terrain types then you should define them at the bottom of this script...
//and edit the following 2 scripts:
//{ platformer_astar_movement , platformer_astar_get_fly_height }
/*
*** Returns: Nothing
*/

globalvar pas_pri_open,pas_map_closed,pas_map_open,pas_lst_x,pas_lst_y,pas_lst_px,pas_lst_py,pas_lst_cst,pas_lst_grids,
pas_px,pas_py,pas_fx,pas_fy,pas_grid,pas_closest,pas_closest_h,pas_height,pas_lst_fall,pas_falling,
pas_min_fall,pas_max_fall,pas_fall_add_min,pas_fall_add_max,pas_failed,pas_debug,pas_debug_cell_size;

pas_pri_open        = ds_priority_create()
pas_map_closed      = ds_map_create()
pas_map_open        = ds_map_create()
pas_lst_x           = ds_list_create()
pas_lst_y           = ds_list_create()
pas_lst_px          = ds_list_create()
pas_lst_py          = ds_list_create()
pas_lst_cst         = ds_list_create()
pas_lst_grids       = ds_list_create()
pas_lst_fall        = ds_list_create()
pas_failed          = false
pas_debug           = false
pas_debug_cell_size = 32
pas_min_fall        = -1
pas_max_fall        = -1
pas_fall_add_min    = -1
pas_fall_add_max    = -1
pas_falling         = false
pas_height          = 1
pas_closest         = 0
pas_closest_h       = 0
pas_grid            = -1
pas_px              = 0
pas_py              = 0
pas_fx              = 0
pas_fy              = 0

globalvar pas_ground,pas_air,pas_water,pas_ladder,pas_platform,pas_danger;
//The different types of terrain - add your own if you want.
pas_air         = 0
pas_ground      = 1000
pas_water       = 2000
pas_ladder      = 3000
pas_platform    = 4000
pas_danger      = 5000
