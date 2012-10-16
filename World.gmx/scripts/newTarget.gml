targetx = argument0
targety = argument1
if argument0=0
{
    targetx = x + random(walkToRange)*2 - walkToRange
    targety = y + random(walkToRange)*2 - walkToRange
}

speed = WALKspeed
direction = point_direction(x,y,targetx,targety)
