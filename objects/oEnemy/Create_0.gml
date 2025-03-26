event_inherited();
randomize();
event_inherited();
spd = .5;
timerWait = game_get_speed(gamespeed_fps) * 2; //2 segundos
timerState = timerWait;
timerAttack = 0;
target = noone;

life = 50;

//HITBOX
hitboxX = x;
hitboxY = y;
rangeX = 20;
rangeY = 10;

pointX = 0;
pointY = 0;
pointSize = 10;

function StateIdle(){
    sprite_index = sEnemyIdle;
    
    target = checkVision(vision, oPlayer.id);
    if(timerAttack > 0){timerAttack--}
    hspd = 0;
    vspd = 0;
    
    timerState--;
    if(timerState <= 0){
        var _chance = random(1);
        face = -face;
        if(_chance > .5){
            state = StateWander;
        }
        timerState = timerWait;
    }
    
    if(target and timerAttack <= 0){
        state = ChaseState;
    }
}

function StateWander(){
    target = checkVision(vision, oPlayer.id);
    if(timerAttack > 0){timerAttack--}
    
    if(sprite_index != sEnemyWalk){
        sprite_index = sEnemyWalk;
        image_index = 0;
        
        hspd = random_range(-spd, spd);
        vspd = random_range(-spd, spd);
    }
    timerState--;
    if(timerState <= 0){
        state = choose(StateIdle, StateWander);
        timerState = timerWait;
    }
    
    if(target and timerAttack <= 0){
        state = ChaseState;
    }
}

vision = 100;
function checkVision(_size = 0, _target = noone){
    if(_target == noone){return false}
    return collision_circle(x, y, _size, _target, 0, 1);
}

function ChaseState(){
    var _dist = point_distance(hitboxX, hitboxY, pointX, pointY);
    
    var _dir = point_direction(hitboxX, hitboxY, pointX, pointY);
    
    hitboxY = y - sprite_height / 2;
    hitboxX = x; 
    
    pointX = target.x;
    pointY = target.y - target.sprite_height/2;
    
    
    var _distX = abs(pointX - hitboxX);
    var _distY = abs(pointY - hitboxY);
    
    if(_distX > vision){
        state = StateWander;
    }
    
    hspd = lengthdir_x(_distX < 15 ? 0 : .5, _dir);
    vspd = lengthdir_y(_distY < 5 ? 0 : .5, _dir); 
    
    if(_distX < 15 and _distY < 5){
        state = StateAttack;
    }
    
    if(sprite_index != sEnemyWalk){
        sprite_index = sEnemyWalk;
        image_index = 0;
    }
}

function StateAttack(){
    hspd = 0;
    vspd = 0;
    delete myDmg;
    if(sprite_index != sEnemyAttack){
        sprite_index = sEnemyAttack;
        image_index = 0;
    }
    
    if(image_index > image_number - 1){
        state = StateWander;
        timerAttack = timerWait;
    }
}

function DamageStateOld(){
    hspd = 0;
    vspd = 0;
    if(sprite_index != sEnemyHurt){
        sprite_index = sEnemyHurt;
        image_index = 0;
    }
    
    x+=.1*target.face;
    image_blend = c_red;
    if(image_index >= image_number-1){
        timerAttack = 20;
        state = StateIdle;
        image_blend = c_white;
    }
}

function DamageState(){
    hspd = 0;
    vspd = 0;
    if(sprite_index != sEnemyHurt){
        sprite_index = sEnemyHurt;
        image_index = 0; // Garante que a animação comece do início sempre que entra no estado de dano
    }

    x += 0.1 * target.face;
    image_blend = c_red;

    if(image_index >= image_number - 1){
        state = StateIdle;
        image_blend = c_white;
    }
}

function DeathState(){
    hspd = 0;
    vspd = 0;
    sprite_index = sEnemyDeath;
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
        image_alpha-=.008;
        if(image_alpha <= 0){
            instance_destroy(id);
        }
    }
}

state = StateIdle;