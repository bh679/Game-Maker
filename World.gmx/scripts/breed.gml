if instance_exists(_other) and isReadyForBaby = true
{
    if distance_to_object(_other) < 1 and _other.girl != girl and _other.isReadyForBaby = true
    {
        
        //add random
        var baby;
        baby = instance_create(x,y,obj_person)
        baby.parent = id;
        baby.leader = id;
        baby.clan = clan
        isReadyForBaby = false
        alarm[0] = 30*40
        
        with(_other){Action(WAIT)}
        Action(WAIT)
    }
}
