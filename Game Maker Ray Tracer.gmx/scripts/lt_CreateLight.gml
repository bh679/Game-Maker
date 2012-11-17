//argument0 - type
//argument1 - x
//argument2 - y
//argument3 - z
//argument4 - color
//argument5 to argument9 - type args
//LT_POINT
//  no args
//LT_SPOT
//  direction x, direction y, direction z, main cutoff angle, soft cutoff angle
{
    global.lt_lights[global.lt_numLights, 0] = argument0;
    global.lt_lights[global.lt_numLights, 1] = argument1;
    global.lt_lights[global.lt_numLights, 2] = argument2;
    global.lt_lights[global.lt_numLights, 3] = argument3;
    global.lt_lights[global.lt_numLights, 4] = argument4;
    //Extra Args
    global.lt_lights[global.lt_numLights, 5] = argument5;
    global.lt_lights[global.lt_numLights, 6] = argument6;
    global.lt_lights[global.lt_numLights, 7] = argument7;
    global.lt_lights[global.lt_numLights, 8] = argument8;
    global.lt_lights[global.lt_numLights, 9] = argument9;
    global.lt_numLights += 1;
    return global.lt_numLights - 1;
}
