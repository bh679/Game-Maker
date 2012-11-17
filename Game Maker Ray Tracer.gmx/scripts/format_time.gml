{
    var time, output;
    
    time = argument0;
    output = "";
    
    if(time > 60 * 60)
    {
        output += string(floor(time / 60 / 60)) + " h  ";
        time -= floor(time / 60 / 60) * 60 * 60;
    }
    if(time > 60)
    {
        output += string(floor(time / 60)) + " m  ";
        time -= floor(time / 60) * 60;
    }
    output += string(time) + " s";
    
    return output;
}
