#macro view view_camera[0]
camera_set_view_size(view, game_width, game_height);
if(instance_exists(oPlayer)){
    var _x = clamp(oPlayer.x - game_width / 2, 0, room_width - game_width);
    var _y = clamp(oPlayer.y - game_height / 2, 0, room_height - game_height);
    
    var _curX = camera_get_view_x(view);
    var _curY = camera_get_view_y(view);
    
    var _spd = .1;
    
    camera_set_view_pos(view, 
                        lerp(_curX, _x, _spd), 
                        lerp(_curY, _y, _spd));
}