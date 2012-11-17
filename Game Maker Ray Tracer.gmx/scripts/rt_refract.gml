//argument0 - ix
//argument1 - iy
//argument2 - iz
//argument3 - nx
//argument4 - ny
//argument5 - nz
//argument6 - refractive index
//argument7 - entering
{
    var invRI, cos1, cos2;
    argument6 *= -1;
    if(argument7)
    {
        invRI = 1 / argument6;
        cos1 = -(argument3 * argument0 + argument4 * argument1 + argument5 * argument2);
        cos2 = sqrt(abs(1 - invRI * invRI * (1 - cos1 * cos1)));
        cos2 *= sign(1 - invRI * invRI * (1 - cos1 * cos1));
        if(cos1 >= 0)
        {
            global.__rt_refractx = argument0 * invRI + argument3 * (invRI * cos1 - cos2);
            global.__rt_refracty = argument1 * invRI + argument4 * (invRI * cos1 - cos2);
            global.__rt_refractz = argument2 * invRI + argument5 * (invRI * cos1 - cos2);
        }
        else
        {
            global.__rt_refractx = argument0 * invRI + argument3 * (invRI * cos1 + cos2);
            global.__rt_refracty = argument1 * invRI + argument4 * (invRI * cos1 + cos2);
            global.__rt_refractz = argument2 * invRI + argument5 * (invRI * cos1 + cos2);
        }
    }
    else
    {
        cos1 = -(argument3 * argument0 + argument4 * argument1 + argument5 * argument2);
        cos2 = sqrt(abs(1 - argument6 * argument6 * (1 - cos1 * cos1)));
        cos2 *= sign(1 - argument6 * argument6 * (1 - cos1 * cos1));
        if(cos1 >= 0)
        {
            global.__rt_refractx = argument0 * argument6 + argument3 * (argument6 * cos1 - cos2);
            global.__rt_refracty = argument1 * argument6 + argument4 * (argument6 * cos1 - cos2);
            global.__rt_refractz = argument2 * argument6 + argument5 * (argument6 * cos1 - cos2);
        }
        else
        {
            global.__rt_refractx = argument0 * argument6 + argument3 * (argument6 * cos1 + cos2);
            global.__rt_refracty = argument1 * argument6 + argument4 * (argument6 * cos1 + cos2);
            global.__rt_refractz = argument2 * argument6 + argument5 * (argument6 * cos1 + cos2);
        }
    }
}
