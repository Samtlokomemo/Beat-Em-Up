var _menu = menu_control[menu_index];
var _centerY = window_get_height() / 2;
var _centerX = window_get_width() / 2
var _sep = 35;
draw_set_font(fntMenu);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(_centerX, 100, "Entre Mundos")
draw_text_transformed(_centerX, 130, "Uma parradaria desenfreada", .8, .8, 0)

for (var i = 0; i < array_length(_menu); i++) {
    ;
    if (i == menu_position) {
        draw_set_color(c_yellow);
        draw_text(_centerX, _centerY + i * _sep, "> " + _menu[i] + " <"); // Item selecionado
    } else {
        draw_set_color(c_white);
        draw_text(_centerX, _centerY + i * _sep, _menu[i]); // Outros itens
    }
}