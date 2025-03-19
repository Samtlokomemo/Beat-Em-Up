with(oEntidade){
    var _escala = z * .009;
    draw_sprite_ext(sSombra, 0, x, y, 2 + _escala, 2 + _escala, 0, c_white, .5 * image_alpha);
}