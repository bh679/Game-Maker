{
    var number_of_processors, default_thread_counts;
    
    global.__rt_width = get_integer("Enter the width of the image to render.  Must be at least 1px.", room_width / 2);
    if(global.__rt_width < 1)
    {
        show_message("Error:  The width of the image to render must be at least 1px.");
        return false;
    }
    
    global.__rt_height = get_integer("Enter the height of the image to render.  Must be at least 1px.", room_height / 2);
    if(global.__rt_height < 1)
    {
        show_message("Error:  The height of the image to render must be at least 1px.");
        return false;
    }
    
    global.__rt_aa_level = get_integer("Enter the level of anti-aliasing (sub-pixel samples) of the image to render.  Must be at least 1x, should be 8x at most.", 2);
    if(global.__rt_aa_level < 1)
    {
        show_message("Error:  The level of anti-aliasing (sub-pixel samples) of the image to render must be at least 1x.");
        return false;
    }
    
    number_of_processors = environment_get_variable("NUMBER_OF_PROCESSORS");
    if(number_of_processors != "" && number_of_processors == string_digits(number_of_processors))
    {
        default_thread_count = real(number_of_processors);
    }
    else
    {
        default_thread_count = 1;
    }
    global.__rt_thread_count = get_integer("Enter the number of threads with which to render the image.  Must be at least 1 thread, should be the number of CPU cores your computer has.", default_thread_count);
    if(global.__rt_thread_count < 1)
    {
        show_message("Error:  There must be at least 1 thread with which to render.");
        return false;
    }
    
    return true;
}
