{
    var i, ii;
    
    if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)"))
    {
        return false;
    }
    if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)\Local Data"))
    {
        return false;
    }
    for(i = 0; i < global.__rt_thread_count; i += 1)
    {
        if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)\Local Data\Thread " + string(i + 1)))
        {
            return false;
        }
    }
    if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)\Roaming Data"))
    {
        return false;
    }
    for(i = 0; i < ds_list_size(global.__rt_list_stages); i += 1)
    {
        if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)\Roaming Data\Stage " + string(i + 1)))
        {
            return false;
        }
        for(ii = 0; ii < global.__rt_thread_count; ii += 1)
        {
            if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)\Roaming Data\Stage " + string(i + 1) + "\Thread " + string(ii + 1)))
            {
                return false;
            }
        }
    }
    if(!parent_create_folder_safe(temp_directory + "\Slave Process(es)\Pause Data"))
    {
        return false;
    }
    if(!parent_create_folder_safe(temp_directory + "\Parent Process"))
    {
        return false;
    }
    for(i = 0; i < ds_list_size(global.__rt_list_stages); i += 1)
    {
        if(!parent_create_folder_safe(temp_directory + "\Parent Process\Stage " + string(i + 1)))
        {
            return false;
        }
        for(ii = 0; ii < global.__rt_thread_count; ii += 1)
        {
            if(!parent_create_folder_safe(temp_directory + "\Parent Process\Stage " + string(i + 1) + "\Thread " + string(ii + 1)))
            {
                return false;
            }
        }
    }
    
    return true;
}
