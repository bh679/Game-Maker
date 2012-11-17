{
    // Argument0 - Argument9 = Standard lt_CreateLight arguments.
    // Argument10 = Radius of soft light sphere.
    // Argument11 = Quality of soft light (number of sphere sub-divisions).
    
    var radius, quality, zo, slice_radius_total, slice_radius, slice_lights, light_power, i, xo, yo;
    
    radius = argument[10];
    quality = argument[11];
    
    slice_radius_total = 0;
    for(zo = -radius; zo <= radius; zo += 2 * radius / quality)
    {
        slice_radius_total += sqrt(radius * radius - zo * zo);
    }
    
    for(zo = -radius; zo <= radius; zo += 2 * radius / quality)
    {
        slice_radius = sqrt(radius * radius - zo * zo);
        slice_lights = round((quality + 1) * (slice_radius / radius));
        if(slice_lights < 1)
        {
            slice_lights = 1;
        }
        
        light_power = (slice_radius / slice_radius_total) / slice_lights;
        
        for(i = 0; i <= slice_lights; i += 1)
        {
            xo = cos(degtorad(i * 360 / slice_lights));
            yo = sin(degtorad(i * 360 / slice_lights));
            lt_CreateLight(argument[0], argument[1] + xo, argument[2] + yo, argument[3] + zo, cl_CreateColor(cl_GetRed(argument[4]) * light_power, cl_GetGreen(argument[4]) * light_power, cl_GetBlue(argument[4]) * light_power), argument[5], argument[6], argument[7], argument[8], argument[9]);
        }
    }
}
