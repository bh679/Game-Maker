{
    /*
        Program parameters:
            0 = Executable path and name.
            
        *** Further parameters are optional, only specified if parameter 1 is "slave" or "pause". ***
            1 = "slave" indicates that the process is a slave thread; "pause" indicates a pause thread.
            2 = File path to "Init.gml" which is executed to initilize the thread.
    */
    
    global.__rt_list_stages = ds_list_create();
    ds_list_add(global.__rt_list_stages, "render_original");
    ds_list_add(global.__rt_list_stages, "render_smart_aa");
    //ds_list_add(global.__rt_list_stages, "render_depth_of_field");
    
    if(parameter_string(1) == "slave")
    {
        rt_object_create_slave();
    }
    else if(parameter_string(1) == "pause")
    {
        rt_object_create_pause();
    }
    else
    {
        rt_object_create_parent();
    }
}
