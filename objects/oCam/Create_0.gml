
game_width = 320;
game_height = 240;
game_scale = 2;

window_set_size(game_width * game_scale, game_height * game_scale);
display_set_gui_size(game_width * game_scale, game_height * game_scale)
window_center();
surface_resize(application_surface, game_width * game_scale, game_height * game_scale)