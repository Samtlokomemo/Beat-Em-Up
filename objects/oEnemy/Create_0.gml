randomize();
event_inherited();
spd = .5;
timerWait = game_get_speed(gamespeed_fps) * 2; //2 segundos
timerState = timerWait;
timerAttack = 0;
target = noone;

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

vision = 70;
function checkVision(_size = 0, _target = noone){
    if(_target == noone){return false}
    return collision_circle(x, y, _size, _target, 0, 1);
}

function ChaseState(){
    
    var _dist = point_distance(x, y, target.x, target.y);
    
    var _dir = point_direction(x, y, target.x, target.y);
    hspd = lengthdir_x(spd, _dir);
    vspd = lengthdir_y(spd, _dir);
    
    if(sprite_index != sEnemyWalk){
        sprite_index = sEnemyWalk;
        image_index = 0;
    }
    
    if(_dist < 15){
        state = StateAttack;
    }
}

function StateAttack(){
    hspd = 0;
    vspd = 0;
    if(sprite_index != sEnemyAttack){
        sprite_index = sEnemyAttack;
        image_index = 0;
    }
    
    if(image_index > image_number - 1){
        state = StateIdle;
        timerAttack = timerWait;
    }
}

state = StateIdle;