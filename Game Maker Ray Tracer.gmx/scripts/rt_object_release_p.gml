{
    var time_delay, file_name, file_handle;
    
    time_delay = current_time;
    draw_text_shadow(10, 10, "####PAUSED (press P to continue)");
    screen_refresh();
    
    file_name = temp_directory + "\Slave Process(es)\Pause Data\Paused.txt";
    file_handle = file_text_open_write(file_name);
    file_text_close(file_handle);
    
    io_clear();
    keyboard_lastkey = 0;
    while(keyboard_lastkey != ord("P") && keyboard_lastkey != vk_escape)
    {
        keyboard_wait();
    }
    if(keyboard_check_pressed(keyboard_lastkey))// Takes care of stupid X button behavior.
    {
        while(keyboard_check(keyboard_lastkey))
        {
            io_handle();
        }
    }
    io_clear();
    
    if(file_exists(file_name))
    {
        file_delete(file_name);
    }
    
    global.__rt_time_start += current_time - time_delay;
}
