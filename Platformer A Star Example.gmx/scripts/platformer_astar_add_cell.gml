//platformer_astar_add_cell(x,y,cost)
//adds a posable movement for the ai to take - mainly for the script: platformer_astar_movement
//cost is a mltiplied by the cost of the cell on the grid
//x&y are relative as shown below
if pas_px>=0
{
    argument0+=pas_px
    argument1+=pas_py
}

//exit if any of the ai's cells is outside the grid
if argument0>=ds_grid_width(pas_grid) || argument0<0
or argument1>=ds_grid_height(pas_grid) || argument1<pas_height-1
return 0

var cst,g,h,f,pos,fall,fall_bonus,i,cst_add;

fall=0
cst=0

//blocks that have already been explored are ignored
if ds_map_exists(pas_map_closed,string(argument0)+","+string(argument1))
return 0

//find the total cost of all the cells the ai is touching
//the cost is between 0 and 999 as 1001 would be the next block type. (eg. 999 is air but 1000 is ground)
for (i=argument1;i>argument1-pas_height;i-=1)
{
    cst_add=ds_grid_get(pas_grid,argument0,i) mod 1000
    
    //a cost of 999 is impassable
    if cst_add>=999
    return 0
    
    cst+=cst_add
}

/*****************************************************************************************************************/
//determining the f cost

//when pas_px is less than 0 the cell has no parent - ie. it is the start cell
if pas_px>=0
{
    //the movement cost is movement cost of previous moves + the cell's cost * argument2
    g=ds_list_find_value(pas_lst_cst,ds_map_find_value(pas_map_closed,string(pas_px)+","+string(pas_py)))+cst*argument2
    h=abs(argument0-pas_fx)+abs(argument1-pas_fy)
    f=g+h
    
    //falling preference equations - falling's bad m'kay
    if pas_falling && pas_max_fall>=0
    {
        fall=ds_list_find_value(pas_lst_fall,ds_map_find_value(pas_map_closed,string(pas_px)+","+string(pas_py)))+1
        
        fall_bonus=0
        if fall>=pas_max_fall
        return 0
        
        if fall>=pas_min_fall
        {
            fall_bonus=(pas_fall_add_max*((fall-pas_min_fall)/(pas_max_fall))+pas_fall_add_min)
                        *(platformer_astar_get_fly_height(argument0,argument1)/(pas_max_fall-pas_min_fall))
        }
        else
        if platformer_astar_get_fly_height(argument0,argument1)>=pas_min_fall
        fall_bonus=pas_fall_add_min*(platformer_astar_get_fly_height(argument0,argument1)/(pas_max_fall-pas_min_fall))
        
        show_debug_message(string(fall_bonus))
        f+=fall_bonus
    }
}
else
{
    g=0
    h=abs(argument0-pas_fx)+abs(argument1-pas_fy)
    f=h
}

/*****************************************************************************************************************/
//adding or editing the cell

//if the cell is in the open map then it needs to be edited instead of added
if ds_map_exists(pas_map_open,string(argument0)+","+string(argument1))
{
    //if the old cell is better than our new cell: Abort!
    if ds_priority_find_priority(pas_pri_open,ds_map_find_value(pas_map_open,string(argument0)+","+string(argument1)))<=f
    return 0
    
    //position of the cell to be replaced
    pos=ds_map_find_value(pas_map_open,string(argument0)+","+string(argument1))
    
    ds_list_replace(pas_lst_px,pos,pas_px)
    ds_list_replace(pas_lst_py,pos,pas_py)
    ds_list_replace(pas_lst_cst,pos,g)
    ds_list_replace(pas_lst_fall,pos,fall)
    ds_priority_change_priority(pas_pri_open,pos,f)
}
else
{
    //all the lists are the same size...
    pos=ds_list_size(pas_lst_x)
    
    ds_list_add(pas_lst_x,argument0)
    ds_list_add(pas_lst_y,argument1)
    ds_list_add(pas_lst_px,pas_px)
    ds_list_add(pas_lst_py,pas_py)
    ds_list_add(pas_lst_cst,g)
    ds_list_add(pas_lst_fall,fall)
    ds_map_add(pas_map_open,string(argument0)+","+string(argument1),pos)
    ds_priority_add(pas_pri_open,pos,f)
}
