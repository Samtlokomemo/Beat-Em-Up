// Inherit the parent event
event_inherited();

if(second_attack_cd > 0){
    draw_healthbar(x - 15, y - 40, x + 15, y - 38, second_attack_cd, c_aqua, c_black, c_blue, 1, true, true)
}