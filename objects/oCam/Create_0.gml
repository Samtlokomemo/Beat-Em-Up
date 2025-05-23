#macro view view_camera[0]
game_width = 320;
game_height = 240;
game_scale = 2;

window_set_size(game_width * game_scale, game_height * game_scale);
display_set_gui_size(game_width * game_scale, game_height * game_scale);
window_center();
surface_resize(application_surface, game_width * game_scale, game_height * game_scale)

state = noone;
target = noone;
xx = 0
yy = 0
curX = 0
curY = 0
spd = .1

function StopInstance(_inst = oPlayer){
    var _x1 = camera_get_view_x(view)
    var _y1 = camera_get_view_y(view)
    
    var _x2 = _x1 + camera_get_view_width(view)
    var _y2 = _y1 + camera_get_view_height(view)
    
    with(_inst){
        var _marg = sprite_width / 2
        x = clamp(x, _x1 + _marg, _x2 - _marg)
        y = clamp(y, _y1, _y2)
    }
}


function StateStop(){
    StopInstance()
    if keyboard_check_pressed(vk_enter){
        state = StatePlayer
    }
}

function StatePlayer(){
    if instance_exists(oPlayer){
        target = oPlayer;
        xx = clamp(target.x - game_width / 2, 0, room_width - game_width);
        yy = clamp(target.y - game_height / 2, 0, room_height - game_height);
    }
    
    curX = camera_get_view_x(view);
    curY = camera_get_view_y(view);

    
    if keyboard_check_pressed(vk_enter){
        state = StateStop
    }
}
state = StatePlayer