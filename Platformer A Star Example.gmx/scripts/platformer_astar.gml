//platformer_astar(grid, output_path, start_x, start_y, end_x, end_y, height, jump_height, jump_hor, max_iterations)
/*
**
**  grid = the cost grid for the A* to work with - a cost grid is created with the 
**         platformer_astar_grid_create function
**
**  output_path = the path to act as the algorythim's host - its memory replaced with a new set of instructions...
**                for pathfinding. Do not just run this path as it has no collision detection - you should instead
**                make your ai try to get from one node to the next using simple ai.
**
**  start_x/start_y = the starting point for the tyrany to follow.
**
**  end_x/end_y = the final goal of the imperial army.
**
**  height = how tall the ai is - in grid cells.
**
**  jump_height = how much of a ninja your ai is. Remember that to jump over a 2 block wall you will need at leat 3
**                jump.
**
**  jump_hor = how far horizontally your ai can jump.
**
**  max_iterations = how many cells can be accepted before the search is called off and the ai is sent to the
**                   nearest (shortest direct distance) cell. -1 for infinite (There won't be a crash if no path is found btw).
**
*** Returns: T/F - if a path was found (includes running out of irritations)
***                to check if the max irritations was reached - check the value of pas_failed (bool)
*/
var sx,sy,pos,irritation,h;

sx=floor(argument2)
sy=floor(argument3)
pas_fx=floor(argument4)
pas_fy=floor(argument5)
pas_grid=ds_list_find_value(pas_lst_grids,argument0)
pas_height=argument6

//ignor out of bounds requests
if pas_fx>=ds_grid_width(pas_grid) || pas_fx<0
or pas_fy>=ds_grid_height(pas_grid) || pas_fy<0
or sy>=ds_grid_height(pas_grid) || sy<0
or sx>=ds_grid_width(pas_grid) || sx<0
return false

/*****************************************************************************************************************/
//create the debugger if pas_debug is true

if pas_debug
{
    var pas_debugger;
    pas_debugger = object_add()
    object_set_depth(pas_debugger,-99999999)
    
    object_event_add(pas_debugger,ev_draw,0,
    "
    var i,xx,yy,px,py,dir;
    draw_set_alpha(0.5)
    for (i = 0;i < ds_list_size(pas_lst_x); i+= 1)
    {
        xx = ds_list_find_value(pas_lst_x,i)
        yy = ds_list_find_value(pas_lst_y,i)
        px = ds_list_find_value(pas_lst_px,i)
        py = ds_list_find_value(pas_lst_py,i)
        draw_rectangle_color(xx*pas_debug_cell_size,yy*pas_debug_cell_size,
                            (xx+1)*pas_debug_cell_size,(yy+1)*pas_debug_cell_size,
                            c_gray,c_gray,c_dkgray,c_dkgray,false)
                            
        //draw_rectangle_color(xx*pas_debug_cell_size,yy*pas_debug_cell_size,
        //                    (xx+1)*pas_debug_cell_size,(yy+1)*pas_debug_cell_size,
        //                    c_black,c_black,c_black,c_black,true)
        
        dir = point_direction(xx,yy,px,py)
        draw_arrow((xx+0.5)*pas_debug_cell_size,(yy+0.5)*pas_debug_cell_size,
                    (xx+0.5)*pas_debug_cell_size+lengthdir_x(pas_debug_cell_size/2,dir),
                    (yy+0.5)*pas_debug_cell_size+lengthdir_y(pas_debug_cell_size/2,dir),2)
    }
    draw_set_alpha(1)
    "
    )
    instance_create(0,0,pas_debugger)
}

/*****************************************************************************************************************/
//add the start cell

pas_px          = -1
pas_py          = -1
pas_closest_h   = 99999999999999999
pas_closest     = -1
platformer_astar_add_cell(sx,sy,0)

//abort if the start cell could not be created
if ds_priority_empty(pas_pri_open)
return false

for (irritation=0;irritation!=argument9;irritation+=1)
{
    /*************************************************************************************************************/
    //remove the current cell from the open map/priority queue and put it on the closed map
    
    pos=ds_priority_find_min(pas_pri_open)
    ds_priority_delete_min(pas_pri_open)
    
    //record the cell's position
    pas_px=ds_list_find_value(pas_lst_x,pos)
    pas_py=ds_list_find_value(pas_lst_y,pos)
    
    ds_map_add(pas_map_closed,string(pas_px)+","+string(pas_py),pos)
    ds_map_delete(pas_map_open,string(pas_px)+","+string(pas_py))
    
    //record the closest cell in case we run out of irritations
    if argument9>=0
    {
        h=abs(pas_px-pas_fx)+abs(pas_py-pas_fy)
        if h<pas_closest_h
        {
            pas_closest_h   = h
            pas_closest     = pos
        }
    }
    
    //redraw for debugging
    if pas_debug
    {
        sleep(3)
        screen_redraw()
    }
    
    /*************************************************************************************************************/
    //check for sucess, move and then check for failure
    
    if pas_px = pas_fx && pas_py = pas_fy
    {
        break;
    }
    
    platformer_astar_movement(argument7, argument8)
    
    if ds_priority_empty(pas_pri_open)
    {
        pas_px=-1
        break;
    }
}

/*****************************************************************************************************************/
//make a best guess if we run out of irritations
pas_failed  = false

if irritation=argument9 && pas_closest>=0
{
    pas_failed  = true
    pas_px      = ds_list_find_value(pas_lst_x,pas_closest)
    pas_py      = ds_list_find_value(pas_lst_y,pas_closest)
}

/*****************************************************************************************************************/
//create the path
if pas_px != -1
{
    path_clear_points(argument1)
    while pas_px!=sx || pas_py!=sy
    {
        path_add_point(argument1,pas_px,pas_py,100)
        pos     = ds_map_find_value(pas_map_closed,string(pas_px)+","+string(pas_py))
        pas_px  = ds_list_find_value(pas_lst_px,pos)
        pas_py  = ds_list_find_value(pas_lst_py,pos)
    }
    path_add_point(argument1,sx,sy,100)
    path_reverse(argument1)
    path_set_closed(argument1,false)
}

/*****************************************************************************************************************/
//clean up

if pas_debug
{
    with pas_debugger
    instance_destroy()
    
    object_delete(pas_debugger)
}

ds_priority_clear(pas_pri_open)
ds_map_clear(pas_map_closed)
ds_map_clear(pas_map_open)
ds_list_clear(pas_lst_x)
ds_list_clear(pas_lst_y)
ds_list_clear(pas_lst_px)
ds_list_clear(pas_lst_py)
ds_list_clear(pas_lst_cst)
ds_list_clear(pas_lst_fall)
lx  = -1
return pas_px != -1
