switch(argument0)
{
    case WALK:
        //move to target
        if point_distance(x,y,targetx,targety) > WALKspeed 
        {
            action = WALK
            Collisions()
            NearBody()
            NearSomeone()
            Action(ATSOMEONE)
            speed = WALKspeed 
            direction = point_direction(x,y,targetx,targety)
            waitTimer = 0
        } 
        //at target 
        else if action = WALK//!Action(WAITING)
            Action(ATTARGET)
        else
            Action(WAITING)
            
        break;
        
    case WAIT:
        action = WAIT
        if random(5) <= 1
        waitTimer = random(3)*30
        break;
        
    case WAITING:
        action = WAITING
        speed = 0;
        //set new target
        if waitTimer <= 0
        {
            if leader = false or distance_to_object(_other) < SIGHT//sprite_height*image_yscale/3+sprite_width*image_xscale/3
            {
                if clan != -1
                    newTarget(walkToRange/2)
                else
                    newTarget()
            }
            else
                newTarget(leader.x,leader.y)
            waitTimer = -1
            return false
        }
        waitTimer -= 1
        return true
        
        break;
    case BURY:
        dead = instance_nearest(x,y,obj_dead)
        //move to target
        if point_distance(x,y,targetx,targety) < WALKspeed and dead.sprite_index = spr_person_dead
        {
            dead.sprite_index = spr_grave
            dead.image_index = random(sprite_get_number(spr_grave))
            Action(WAIT)
        }
        break;
    case ATTARGET:
        //following clan
        Action(ATSOMEONE)
        Action(WAIT)
        break;
    case ATSOMEONE:
        if instance_exists(_other)
        {
            //both in same clan, who cares distance
            if clan = _other.clan and clan != -1 and isLeader = false
            {
                
            }
            //reached someone not both in same clan
            else if distance_to_object(_other) < InReach
            {
                //found a follower
                if clan = _other.clan and isLeader = true
                {
                    _other.leader = id
                    _other.isLeader = false
                }
                //kill
                else if state = AGRESSIVE and clan != _other.clan
                    {with(_other){ createDead(MAN) instance_destroy()}}
                //make friends
                else if state = FRIENDLY
                {
                    //invite to clan
                    if _other.clan = -1
                    {
                        //make new clan
                        if clan = -1
                        {
                            clan = floor(random(CLANS))
                            isLeader = true
                            leader = false
                        }
                        _other.clan = clan
                        _other.leader = id
                    //join clan
                    }else
                    {
                        //leader = _other
                        if clan = -1 and _other.clan = -1
                        {
                            clan = floor(random(CLANS))
                            isLeader = true
                            leader = false
                            _other.clan = clan
                            _other.leader = id
                        }else if clan = -1 
                        {
                            clan = _other.clan
                            leader = _other
                        }
                        else
                        {
                            _other.clan = clan
                            _other.leader = id
                        }
                    }
                }
            }
        }
        break;
}

return false
