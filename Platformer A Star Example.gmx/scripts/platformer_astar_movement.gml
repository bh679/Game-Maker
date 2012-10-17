//platformer_astar_movement(jump_vert,jump_horr)
//
//This script contains the platforming movement code - alter as you wish - it isn't too complex.
//For diagonal movements the cost gets multiplied by 1.4 because that is a rough approximation of sqrt(2)
//and the distance between diagonal cells = sqrt(sqr(x1-x2)+sqr(y1-y2)) = sqrt(1+1) = sqrt(2) = 1.4
//
//This script basically checks what cell the ai is both in and on, and based on that decides what cells to
//make available to the ai. Therefore a good way to make something dangerous is to not allow the ai to go
//anywhere if it were to land on it - therefore is is thought of as a "dead end" and ignored/avoided.
//
//if you are wondering what all the 0s, -1s and 1s are - they are relative coordinates when checking and setting cells.
/*
*** Returns: Nothing
*/
var jump,cell_below,i,j,current_cell;

jump_vert=argument0
jump_hor=argument1
cell_below=platformer_astar_get_cell_type(0,1)

current_cell=platformer_astar_get_cell_type(0,0)

//Allow the ai to grab ladders using their arms
if platformer_astar_get_touching_type(0,0,pas_ladder)
current_cell=pas_ladder

switch current_cell
{
    /*************************************************************************************************************/
    //swimming
    
    case pas_water:
        //moving left and right
        if platformer_astar_position_free(-1,0)
        platformer_astar_add_cell(  -1,    0,    1)
        
        if platformer_astar_position_free(1,0)
        platformer_astar_add_cell(   1,    0,    1)
        
        //moving up and diagonally up, you can't exit the water at an angle
        if platformer_astar_position_free(0,-1)
        {
            platformer_astar_add_cell(   0,   -1,    1)
            
            if platformer_astar_position_free(-1,-1)
            platformer_astar_add_cell_if_type(  -1,    -1,    1.4,     pas_water)
            
            if platformer_astar_position_free(1,-1)
            platformer_astar_add_cell_if_type(   1,    -1,    1.4,     pas_water)
        }
        
        //moving down and diaggonly down - costs more to avoid drowning
        if platformer_astar_position_free(0,1)
        {
            platformer_astar_add_cell(   0,    1,    1.5)
            
            if platformer_astar_position_free(-1,1)
            platformer_astar_add_cell(  -1,     1,    2.1)
            
            if platformer_astar_position_free(1,1)
            platformer_astar_add_cell(   1,     1,    2.1)
        }
    break;
    
    /*************************************************************************************************************/
    //normal movement, digging and walking on ladders/water
    
    case pas_air:
    case pas_platform:
    case pas_ground:
        //walking on the ground, exiting water, getting off a ladder
        if cell_below=pas_ground || cell_below=pas_water || cell_below=pas_ladder || cell_below=pas_platform
        or cell_below=pas_danger
        {
            //dangers cause abortions!
            if cell_below=pas_danger
            return 0
            
            if cell_below=pas_water || cell_below=pas_ladder
            {
                //walking on water/ladders is not posable unless you are exiting the water/ladder
                if platformer_astar_position_free(-1,0) && platformer_astar_get_cell_type(-1,1)=pas_ground
                platformer_astar_add_cell(  -1,    0,    3)
                
                if platformer_astar_position_free(1,0) && platformer_astar_get_cell_type(1,1)=pas_ground
                platformer_astar_add_cell(   1,    0,    3)
            }
            else
            if cell_below=pas_ground || cell_below=pas_platform
            {
                //walking left and right
                if platformer_astar_position_free(-1,0)
                platformer_astar_add_cell(  -1,    0,    1)
                
                if platformer_astar_position_free(1,0)
                platformer_astar_add_cell(   1,    0,    1)
                
                var max_left, max_right;
                max_right = 9999
                max_left  = 9999
                //jumping is only posable on the ground or platforms
                for (j = 1; j < jump_vert && platformer_astar_position_free(0, -j); j += 1)
                {
                    platformer_astar_add_cell(   0,    -j,    j)
                    
                    for (i=1;i <= min(jump_hor, j, max_right) && platformer_astar_position_free(i, -j);i+=1)
                    platformer_astar_add_cell(   i,    -j,    point_distance(0, 0, i, j))
                    
                    max_right = i
                    
                    for (i=1;i <= min(jump_hor, j, max_left) && platformer_astar_position_free(-i, -j);i+=1)
                    platformer_astar_add_cell(  -i,    -j,    point_distance(0, 0, i, j))
                    
                    max_left = i
                }
            }
            
            //you can submerge in water / climb down a ladder / dig downwards / drop through a platform
            if platformer_astar_position_free(0,1)
            {
                platformer_astar_add_cell(   0,    1,    1)
                //moving down left and down right - you can't dig diagonally
                if cell_below!=pas_ground
                {
                    if platformer_astar_position_free(-1,1)
                    platformer_astar_add_cell(  -1,    1,    1.4)
                    
                    if platformer_astar_position_free(1,1)
                    platformer_astar_add_cell(   1,    1,    1.4)
                }
            }
        }
        else
        //falling
        {
            if platformer_astar_position_free(0,1)
            {
                platformer_astar_add_cell_falling(   0,    1,    1)
                //moving down left and down right
                if platformer_astar_position_free(-1,1)
                platformer_astar_add_cell_falling(  -1,    1,    1.4)
                
                if platformer_astar_position_free(1,1)
                platformer_astar_add_cell_falling(   1,    1,    1.4)
            }
        }
    break;
    
    /*************************************************************************************************************/
    //climbing a ladder / flying - simple 8 directional A*
    
    case pas_ladder:
        //moving left and right
        if platformer_astar_position_free(-1,0)
        platformer_astar_add_cell(  -1,    0,    1)
        
        if platformer_astar_position_free(1,0)
        platformer_astar_add_cell(   1,    0,    1)
        
        //moving down
        if platformer_astar_position_free(0,1)
        {
            platformer_astar_add_cell(   0,    1,    1)
            //moving down left and down right
            if platformer_astar_position_free(-1,1)
            platformer_astar_add_cell(  -1,    1,    1.4)
            
            if platformer_astar_position_free(1,1)
            platformer_astar_add_cell(   1,    1,    1.4)
        }
        
        //moving up
        if platformer_astar_position_free(0,-1)
        {
            platformer_astar_add_cell(   0,   -1,    1)
            //moving down left and down right
            if platformer_astar_position_free(-1,-1)
            platformer_astar_add_cell(  -1,   -1,    1.4)
            
            if platformer_astar_position_free(1,-1)
            platformer_astar_add_cell(   1,   -1,    1.4)
        }
    break;
}
