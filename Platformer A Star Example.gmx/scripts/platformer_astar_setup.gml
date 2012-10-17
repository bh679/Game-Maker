//platformer_astar_setup(fall_pain_dist,max_fall_dist,min_pain_bonus,max_pain_bonus)
//you don't need to call this - it simply sets up how the ai reacts to long falls
//setting any of the arguments to a negative number results in the ai not avoiding falls
/*
**
**  fall_pain_dist = the distance at which the ai starts to get second thoughts about a fall
**
**  max_fall_dist = the distance at which the ai will draw the line and avoid accidental scuicide
**
**  min_pain_bonus = when a fall is going to hurt a little - how much does the ai dislike the concept of falling.
**
**  max_pain_bonus = when a fall is going leave the ai mentally scared - how much does the ai dislike the concept
**                   of falling.
**
*** Returns: Nothing
*/

if argument0 <0 || argument1 <0 || argument2 <0 || argument3 <0
{
    pas_min_fall=-1
    pas_max_fall=-1
    pas_fall_add_min=-1
    pas_fall_add_max=-1
}
else
{
    pas_min_fall=argument0
    pas_max_fall=argument1
    pas_fall_add_min=argument2
    pas_fall_add_max=argument3-argument2
}
