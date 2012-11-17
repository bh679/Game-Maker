{
    directory_create(argument[0]);
    
    if(directory_exists(argument[0]))
    {
        return true;
    }
    else
    {
        show_message("Error:  Could not create folder " + chr(34) + argument[0] + chr(34) + ".");
        return false;
    }
}
