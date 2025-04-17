//Escurecer tela conforme a vida do player
draw_set_alpha(alpha);
draw_rectangle_color(0,0,window_get_width(), window_get_height(), c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

var barraX = 10;
var barraY = 10;
var barraLargura = 150;
var barraAltura = 20;

var porcentagem = oPlayer.life / oPlayer.maxLife;
var larguraVida = barraLargura * porcentagem;

draw_set_color(#2F0304);
draw_rectangle(barraX, barraY, barraX + barraLargura, barraY + barraAltura, false);
draw_set_color(c_red);
draw_rectangle(barraX, barraY, barraX + larguraVida, barraY + barraAltura, false);
draw_set_color(c_white);