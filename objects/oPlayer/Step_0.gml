//Movimentação
var _up     = keyboard_check(ord("W"));
var _left   = keyboard_check(ord("A"));
var _down   = keyboard_check(ord("S"));
var _right  = keyboard_check(ord("D"));

var _moveX = (_right - _left);
var _moveY = (_down - _up);

//Faz uma pitágoras para normalizar a velocidade independente da direção
var _dir = point_direction(0, 0, _moveX, _moveY);
var _len = point_distance(0, 0, _moveX, _moveY);
if (_len > 0) {
    _moveX = lengthdir_x(_len * spd, _dir);
    _moveY = lengthdir_y(_len * spd, _dir);
}

//Colisão
if place_meeting(x + _moveX, y, oBlock){
    while !place_meeting(x + sign(_moveX), y, oBlock){
        x += sign(_moveX);
    }
    _moveX = 0;
}
x += _moveX;

if place_meeting(x, y + _moveY, oBlock){
    while !place_meeting(x, y + sign(_moveY), oBlock){
        y += sign(_moveY)
    }
    _moveY = 0;
}
y += _moveY;