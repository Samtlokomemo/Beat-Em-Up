var _centerW = window_get_width() / 2;
var _centerH = window_get_height() / 2;

draw_set_font(fntMenu);
draw_set_alpha(1);
draw_set_color(-1);
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_transformed(_centerW, _centerH, "GAME OVER", 2, 2, 0);
draw_set_alpha(alpha);
draw_set_color(c_yellow);
draw_text_transformed(_centerW, _centerH + 50, "press Z to continue", .5, .5, 0);

//Resetando as mudanças
draw_set_alpha(1);

