//argument0 - light
//argument1 - lvx
//argument2 - lvy
//argument3 - lvz
{
    var dot, angle;
    if(global.lt_lights[argument0, 0] == LT_POINT)
    {
        return 1;
    }
    if(global.lt_lights[argument0, 0] == LT_SPOT)
    {
        dot = argument1 * global.lt_lights[argument0, 5] + argument2 * global.lt_lights[argument0, 6] + argument3 * global.lt_lights[argument0, 7];
        dot = median(-1, dot, 1);
        angle = arccos(dot);
        if(angle <= global.lt_lights[argument0, 8] - global.lt_lights[argument0, 9])
        {
            return sqrt(angle / global.lt_lights[argument0, 8]);
        }
        else if(angle <= global.lt_lights[argument0, 8])
        {
            return sqrt(angle / global.lt_lights[argument0, 8]) * (global.lt_lights[argument0, 8] - angle) / global.lt_lights[argument0, 9];
        }
        else
        {
            return 0;
        }
    }
}
