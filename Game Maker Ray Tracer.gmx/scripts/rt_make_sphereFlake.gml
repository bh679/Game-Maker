{
    var xx, yy, zz, r, mat, theta;
    
    xx = argument[0];
    yy = argument[1];
    zz = argument[2];
    r = argument[3];
    mat = argument[4];
    
    sh_CreateShape(SH_SPHERE, xx, yy, zz, r, false, false, mat);
    
    if(r >= 50 / 3)// / 3)// Set recursion level here.
    {
        for(theta = 0; theta < 360; theta += 360 / 3)
        {
            rt_make_sphereFlake(xx + cos(degtorad(theta)) * r * 4 / 3 * cos(degtorad(60)), yy + sin(degtorad(theta)) * r * 4 / 3 * cos(degtorad(60)), zz + r * 4 / 3 * sin(degtorad(60)), r / 3, mat);
        }
        for(theta = 0; theta < 360; theta += 360 / 6)
        {
            rt_make_sphereFlake(xx + cos(degtorad(theta)) * r * 4 / 3, yy + sin(degtorad(theta)) * r * 4 / 3, zz, r / 3, mat);
        }
        for(theta = 0; theta < 360; theta += 360 / 3)
        {
            rt_make_sphereFlake(xx + cos(degtorad(theta)) * r * 4 / 3 * cos(degtorad(60)), yy + sin(degtorad(theta)) * r * 4 / 3 * cos(degtorad(60)), zz - r * 4 / 3 * sin(degtorad(60)), r / 3, mat);
        }
    }
}
