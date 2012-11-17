{
    var var_previous_color, var_previous_alpha, var_x, var_y;
    
    var_previous_color = draw_get_color();
    var_previous_alpha = draw_get_alpha();
    
    draw_set_color(c_black);
    
    for(var_x = 1; var_x <= 3; var_x += 1)
    {
        for(var_y = 0; var_y <= 2 * pi; var_y += pi / 8)
        {
            draw_set_alpha(0.15 / var_x);
            draw_text(argument0 + var_x * cos(var_y) + 1, argument1 + var_x * sin(var_y) + 1, argument2);
        }
    }
    
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_text(argument0, argument1, argument2);
    
    draw_set_color(var_previous_color);
    draw_set_alpha(var_previous_alpha);
}
