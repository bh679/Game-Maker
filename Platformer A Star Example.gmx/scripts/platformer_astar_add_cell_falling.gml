//platformer_astar_add_cell_falling(x,y,cost)
//exact same as platformer_astar_add_cell - except that the cell thinks it's falling.
//ie. if the ai would be falling if it went to this cell.
//ony for the script: platformer_astar_movement
//x&y are relative

pas_falling=true
platformer_astar_add_cell(argument0,argument1,argument2)
pas_falling=false
