if age < 18
{
    image_xscale = scale*(age/18*1/2 + 1/2)
    image_yscale = scale*(age/18*1/2 + 1/2)
    
    if age < 1
        WALKspeed = 0.5
    else if age < 5
        WALKspeed = 1.5
    else if age < 15
    {
        WALKspeed = 2
        alarm[0] = 1
    }
    else
        WALKspeed = 1.5
    
}else
{   
    if age < 50
        WALKspeed = 1
    else if age < death
        WALKspeed = 1 - age/100
    else
        die()
    image_xscale = scale 
    image_yscale = scale
}
