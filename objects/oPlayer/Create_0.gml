event_inherited();
spd = 2;
hspd = 0;
vspd = 0;
zspd = 0;
face = 1;

z = 0;
grav = .3;
jumpHeight = 6;

attack = noone;

state = noone;


// Variáveis de controle do ataque (adicione no seu evento Create):
attacking = false;
hitboxCreated = false;
combo_stage = 0;
combo_timer = 0;
combo_window = 10; // Ajuste conforme necessário
attack_sprite = noone;
attack_hitbox_sprite = noone;
attack_damage = 0;
attack_offset = 0; // Ajuste conforme a necessidade

function PlayerControls(){
    //Movimentação
    var _up     = keyboard_check(ord("W")) || keyboard_check(vk_up);
    var _left   = keyboard_check(ord("A")) || keyboard_check(vk_left);
    var _down   = keyboard_check(ord("S")) || keyboard_check(vk_down);
    var _right  = keyboard_check(ord("D")) || keyboard_check(vk_right);

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
    
    var _jump   = keyboard_check(vk_space);
    
    if(_jump and state != StateJump){
        state = StateJump;
        zspd = -jumpHeight;
    }
    
    _hit   = keyboard_check_pressed(ord("Z"));
    _kick  = keyboard_check_pressed(ord("X"));

    if((_hit or _kick) and state != StateJump){
        state = StateAttack;
    }

    if(_jump and state != StateJump){
        state = StateJump;
        zspd = -jumpHeight;
    }
    
    var _dash   = keyboard_check_pressed(vk_shift);
    
    if(_dash and state != StateJump){
        dashTime = 10;
        state = StateDash;   
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

// Funções para iniciar e continuar o combo (adicione no seu script ou no Create):
function StartCombo(_anim_sprite, _hitbox_sprite, _damage) {
    attacking = true;
    combo_stage = 1;
    combo_timer = 0;
    sprite_index = _anim_sprite;
    image_index = 0;
    attack_sprite = _anim_sprite;
    attack_hitbox_sprite = _hitbox_sprite;
    attack_damage = _damage;
    hitboxCreated = false;
}

function ContinueCombo(_anim_sprite, _hitbox_sprite, _damage) {
    combo_stage++;
    combo_timer = 0;
    sprite_index = _anim_sprite;
    image_index = 0;
    attack_sprite = _anim_sprite;
    attack_hitbox_sprite = _hitbox_sprite;
    attack_damage = _damage;
    hitboxCreated = false;
}

function StateAttack(){

    // Inicialização do ataque (se não estivermos já em um ataque)
    if (!attacking) {
        if (_hit) {
            StartCombo(sPlayerPunch, sPlayerPunchHB, 10);
        } else if (_kick) {
            StartCombo(sPlayerKick, sPlayerKickHB, 15);
        }
    } else {
        // Lógica de combo
        combo_timer++;
        if (combo_timer <= combo_window) {
            if (_hit) {
                if (combo_stage == 1 && sprite_index == sPlayerPunch && image_index >= sprite_get_number(sprite_index) - 2) {
                    ContinueCombo(sPlayerHandAttack, sPlayerHandAttackHB, 5);
                }
            } else if (_kick) {
                // Adicione aqui a lógica para combos que começam ou continuam com chute
            }
        }
        
        if (attacking && attack_hitbox_sprite != noone && !hitboxCreated) {
            var _hitbox_frame = -1; // Inicializa com um valor inválido
        
            if (attack_sprite == sPlayerPunch) {
                _hitbox_frame = 3; // O ataque do soco começa no frame 3 (lembrando que o índice começa em 0)
            } else if (attack_sprite == sPlayerKick) {
                _hitbox_frame = 4; // O ataque do chute começa no frame 5
            }
            // Adicione condições 'else if' para outros ataques se você tiver mais
        
            if (_hitbox_frame != -1 && sprite_index == attack_sprite && image_index == _hitbox_frame) {
                var _inst = instance_create_depth(x, y, depth, oEnemyHitbox);
                _inst.image_xscale = face;
                _inst.sprite_index = attack_hitbox_sprite;
                _inst.creator = id;
                hitboxCreated = true;
            }
        }
    
        // Transição para Idle quando a animação terminar
        if (image_index >= sprite_get_number(sprite_index) - 1) {
            attacking = false;
            combo_stage = 0;
            state = StateIdle;
        }
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
    } else {
        zspd = 0;
        z = 0;
        spd = 2;
        state = StateIdle;
    }
}

function DamageState(){
    if(sprite_index != sPlayerHurt){
        image_index = 0;
        sprite_index = sPlayerHurt;
    }
    image_blend = c_red;
    if(image_index >= image_number-1){
        invulnerableTime = invulnerableDuration;
        image_blend = c_white;
        if(life >= 0){
            state = StateJump;
        }
    }
}

function StateDash(){
    var dashSpeed = 10 * face;
    var dashStep = abs(dashSpeed);
    var dashDistance = abs(dashSpeed);
    var moved = 0;

    for (var i = 0; i < dashStep; i++) {
        var nextX = x + sign(dashSpeed);
        if (!place_meeting(nextX, y, oBlock)) {
            x += sign(dashSpeed);
            moved += abs(sign(dashSpeed));
            if (moved >= dashDistance) break;
        } else {
            break;
        }
    }

    p = instance_create_depth(x, y, depth, oDash);
    dashTime--;
    if(dashTime <= 0){
        state = StateIdle;
    }
}

function StateDeath(){
    sprite_index = sPlayerDeath;
    oEnemy.target = noone;
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
        image_alpha -= .01;
        if(image_alpha <= 0){
            room_goto(rmGameOver);
        }
    }
}

function Parallax(){
    var _backGround = layer_get_id("Background");
    var _foreGround = layer_get_id("TileSetBG");
    
    //Pegando a posição da câmera
    var _x = camera_get_view_x(view_camera[0]);
    var _y = camera_get_view_y(view_camera[0]);
    
    //Mudando a posição do fundo com uma velocidade reduzida (Parallax)
    layer_x(_backGround, _x / 2);
    layer_y(_backGround, _y / 2);
    layer_x(_foreGround, _x / 8);
    layer_y(_foreGround, _y / 8);
}

state = StateIdle;
