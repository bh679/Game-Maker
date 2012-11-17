{
    var bx, by, o;
    
    bx = argument[0];
    by = argument[1];
    o = argument[2];
    
    //return (sqrt(bx * bx + by * by) < o) / (pi * o * o) + EPSILON;// Test for hard circle-of-confusion bokeh effect.
    return (1 / (2 * pi * o * o)) * exp(-(bx * bx + by * by) / (2 * o * o));
}
