dead = instance_create(x,y,obj_dead)
dead.image_speed = 0

switch(argument0)
{
    case MAN: 
        dead.sprite_index = spr_person_dead
}

dead.image_index = random(sprite_get_number(dead.sprite_index))
dead.image_xscale = image_xscale
dead.image_yscale = image_yscale
