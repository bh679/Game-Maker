{
    if(file_exists(global.__rt_parent_directory + "\Slave Process(es)\Pause Data\Paused.txt"))
    {
        execute_program(parameter_string(0), "pause " + chr(34) + global.__rt_parent_directory + chr(34), true);
    }
}
