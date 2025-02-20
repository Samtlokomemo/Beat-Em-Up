spd = 2;
hspd = 0;
vspd = 0;
zspd = 0;
state = noone;
textState = " ";

function PlayerControls(){
    //Movimentação
    var _up     = keyboard_check(ord("W")) || keyboard_check(vk_up);
    var _left   = keyboard_check(ord("A")) || keyboard_check(vk_left);
    var _down   = keyboard_check(ord("S")) || keyboard_check(vk_down);
    var _right  = keyboard_check(ord("D")) || keyboard_check(vk_right);
    var _hit    = keyboard_check_pressed(ord("Z"));
    
    #region Movimentação
    hspd = (_right - _left);
    vspd = (_down - _up);
    
    if(hspd != 0){
        image_xscale = sign(hspd);
    }
    
    //Faz uma pitágoras para normalizar a velocidade independente da direção
    var _dir = point_direction(0, 0, hspd, vspd);
    var _len = point_distance(0, 0, hspd, vspd);
    if (_len > 0) {
        hspd = lengthdir_x(_len * spd, _dir);
        vspd = lengthdir_y((_len * spd)/2, _dir);
    }
    
    //Colisão
    if place_meeting(x + hspd, y, oBlock){
        while !place_meeting(x + sign(hspd), y, oBlock){
            x += sign(hspd);
        }
        hspd = 0;
    }
    x += hspd;
    
    if place_meeting(x, y + vspd, oBlock){
        while !place_meeting(x, y + sign(vspd), oBlock){
            y += sign(vspd)
        }
        vspd = 0;
    }
    y += vspd;
    
    if(_hit){
        state = StateAttack;
    }
}

function StateIdle(){
    textState = "Idle";
    sprite_index = sPlayerIdle;
    PlayerControls();
    if(hspd != 0 or vspd != 0){
        state = StateWalk;
    }
}

function StateWalk(){
    textState = "Walk";
    sprite_index = sPlayerWalk;
    PlayerControls();
    if(hspd == 0 and vspd == 0){
        state = StateIdle;
    }
}

function StateAttack(){
    textState = "Attack";
    
    if(sprite_index != sPlayerHandAttack){
        image_index = 0;
        sprite_index = sPlayerHandAttack;
    }
    if(image_index >= image_number-1){
        state = StateIdle;
    }
}

state = StateIdle;