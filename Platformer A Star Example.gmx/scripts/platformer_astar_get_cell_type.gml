//platformer_astar_get_cell_type(x,y)
//returns the terrain type at the relative position (x,y) - ony for the script: platformer_astar_movement
//x&y are relative as shown below
if pas_px>=0
{
    argument0+=pas_px
    argument1+=pas_py
}

return floor(ds_grid_get(pas_grid,argument0,argument1)/1000)*1000
