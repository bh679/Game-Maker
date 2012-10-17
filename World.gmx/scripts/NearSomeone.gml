//show_message('bout time')
_other = instance_nth_nearest(x,y,obj_person,2)


if (distance_to_object(_other) < SIGHT)
{
    
    var people, othertarget;
    people = instance_number(obj_person)
    
    othertarget = _other
    for(i = 2; i < people-1; i += 1)
    {
        _other = instance_nth_nearest(x,y,obj_person,i)
        if (distance_to_object(_other) < SIGHT)
        and (!collision_line(x,y,_other.x,_other.y,obj_tree,1,0)) 
        and (clan = -1 or clan != _other.clan)
        {
            othertarget = _other
            closestTargetX = _other.x
            closestTargetY = _other.y
            if state != NOTHING
                newTarget(_other.x,_other.y)
            if hasClan(id)
            {
                if _other.clan = obj_clan.enemyClan[clan]
                    return 0;
            }
        }
    }
    _other = othertarget
}
