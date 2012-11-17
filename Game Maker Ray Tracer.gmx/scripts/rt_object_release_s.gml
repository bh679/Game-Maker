{
    var save_filename, stages;
    
    save_filename = get_save_filename("PNG Image (*.png)|*.png|Bitmap Image (*.bmp)|*.bmp|JPEG Image (*.jpg, *.jpeg)|*.jpg;*.jpeg", "Game Maker Ray Tracer Image.png");
    if(save_filename != "")
    {
        if(ds_list_size(global.__rt_list_stages) > 1)
        {
            stages = show_message_ext("Which stage(s) of the image do you wish to save?", "&All", "&Current", "&Up To Current");
        }
        else
        {
            stages = 1;
        }
        
        if(stages != 0)
        {
            rt_image_save(save_filename, stages);
        }
    }
}
