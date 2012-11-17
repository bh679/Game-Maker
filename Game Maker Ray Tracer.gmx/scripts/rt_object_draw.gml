{
    room_caption = "Game Maker Ray Tracer (" + string(global.__rt_width) + " x " + string(global.__rt_height) + " px @ " + string(global.__rt_aa_level) + "x AA with " + string(global.__rt_thread_count) + " threads - " + string(fps) + "/" + string(room_speed) + " FPS)";
    
    rt_object_draw_image();
    rt_object_draw_status();
}
