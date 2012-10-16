var people, _other;
people = instance_number(obj_person)

for(i = 0; i < people; i += 1)
{
    _other = instance_nth_nearest(x,y,i,obj_dead)
    if distance_to_object(_other) < SIGHT and (!collision_line(x,y,_other.x,_other.y,obj_tree,1,0)) and _other.sprite_index = spr_person_dead
    {
        newTarget(_other.x,_other.y)
        Action(BURY)
    }
}
