{
    window_set_visible(false);
    set_program_priority(-2);// Low priority.
    room_speed = 1;
    instance_create(0, 0, obj_pause);
    instance_destroy();
}
