{
    var i, s, out_of_shadow;
    
    i = argument[0];
    out_of_shadow = true;
    
    for(s = 0; s < global.__rt_numShapes; s += 1)
    {
        if(sh_RayCast(argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], s))
        {
            if(global.ry_t < argument[7])
            {
                out_of_shadow = 0.5;// Leave some light for diffuse inter-reflection.
            }
        }
    }
    
    return out_of_shadow;
}
