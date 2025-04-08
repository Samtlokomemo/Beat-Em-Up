draw_sprite_ext(sprite_index, image_index, x, y + z, image_xscale * face, image_yscale, image_angle, image_blend, image_alpha);
if(is_struct(myDmg)){
    draw_set_color(c_blue);
    //myDmg.draw_area();
    myDmg.collision_check();
}