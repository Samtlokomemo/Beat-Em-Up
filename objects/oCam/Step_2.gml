camera_set_view_size(view, game_width, game_height);
camera_set_view_pos(view, 
                    lerp(curX, xx, spd), 
                    lerp(curY, yy, spd));
state();
show_debug_message(state)