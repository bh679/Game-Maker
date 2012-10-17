//platformer_astar_add_cell_if_type(x,y,cost,type)
//adds the cell if it is of a certain terrain type - ony for the script: platformer_astar_movement
//see: platformer_astar_add_cell
//x&y are relative as shown below
var xx,yy,rtn;

if pas_px>=0
{
    xx=argument0+pas_px
    yy=argument1+pas_py
}

rtn=floor(ds_grid_get(pas_grid,xx,yy)/1000)*1000
if rtn=argument3
platformer_astar_add_cell(argument0,argument1,argument2)

return rtn
