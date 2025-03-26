event_inherited();
state();
Parallax();
if(is_struct(myDmg)){
    myDmg.update_area();
}
if(life <= 0){
    sprite_index = sPlayerHurt;
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
        image_alpha -= .01;
        if(image_alpha <= 0){
            room_goto(rmGameOver);
        }
    }
}
