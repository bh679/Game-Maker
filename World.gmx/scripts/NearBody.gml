body = instance_nearest(x,y,obj_dead)
if distance_to_object(body) < SIGHT and (!collision_line(x,y,body.x,body.y,obj_tree,1,0)) and body.sprite_index = spr_person_dead
{
    newTarget(body.x,body.y)
    Action(BURY)
}
