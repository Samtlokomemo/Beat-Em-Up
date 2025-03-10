myDmg = noone;
spd = 2;
hspd = 0;
vspd = 0;
zspd = 0;
face = 1;

z = 0;
grav = .3;
jumpHeight = 6;

state = noone;

function PlayerControls(){
    //Movimentação
    var _up     = keyboard_check(ord("W")) || keyboard_check(vk_up);
    var _left   = keyboard_check(ord("A")) || keyboard_check(vk_left);
    var _down   = keyboard_check(ord("S")) || keyboard_check(vk_down);
    var _right  = keyboard_check(ord("D")) || keyboard_check(vk_right);
    var _hit    = keyboard_check_pressed(ord("Z"));
    var _jump   = keyboard_check(vk_space);
    
    #region Movimentação
    hspd = (_right - _left);
    vspd = (_down - _up);
    
    if(hspd != 0){
        face = sign(hspd);
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
    
    if(_hit and state != StateJump){
        state = StateAttack;
    }
    
    if(_jump and state != StateJump){
        state = StateJump;
        zspd = -jumpHeight;
    }
}

function StateIdle(){
    sprite_index = sPlayerIdle;
    PlayerControls();
    if(hspd != 0 or vspd != 0){
        state = StateWalk;
    }
}

function StateWalk(){
    sprite_index = sPlayerWalk;
    PlayerControls();
    if(hspd == 0 and vspd == 0){
        state = StateIdle;
    }
}

function StateAttack(){
    if(sprite_index != sPlayerHandAttack){
        image_index = 0;
        sprite_index = sPlayerHandAttack;
    }
    if(image_index >= image_number-1){
        state = StateIdle;
        delete myDmg;
    }
}

function StateJump(){
    if(sprite_index != sPlayerJump && zspd <= 0){
        sprite_index = sPlayerJump; 
        image_index = 0;
    }
    
    PlayerControls();
    
    if(image_index >= image_number-1){
        image_index = image_number-2;
    }
    
    if(zspd > 0){
        image_index = image_number-1;
    }
    
    spd = 1.5;
    z += zspd;
    if(z < 0){
       zspd += grav;
    }else{
        zspd = 0;
        z = 0;
        spd = 2;
        state = StateIdle;
    }
    
}

function Parallax(){
    var _layer = layer_get_id("Background");
    
    //Pegando a posição da câmera
    var _x = camera_get_view_x(view_camera[0]);
    var _y = camera_get_view_y(view_camera[0]);
    
    //Mudando a posição do fundo com uma velocidade reduzida (Parallax)
    layer_x(_layer, _x / 4);
    layer_y(_layer, _y / 4);
}

state = StateIdle;