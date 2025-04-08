event_inherited();
//Enemy Hitbox
//draw_rectangle(hitboxX, hitboxY, hitboxX + rangeX * face, hitboxY - rangeY, true);
//Player Hitbox
//draw_rectangle(pointX, pointY, pointX + pointSize * -face, pointY - pointSize, true);
if(state == ChaseState){
    draw_set_color(c_red);
    draw_set_font(fntArial);
    draw_text(x, y - sprite_height - 20, "!");
}