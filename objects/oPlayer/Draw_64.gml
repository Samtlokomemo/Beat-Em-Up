draw_set_color(#2F0304);
draw_rectangle(10, 10, maxLife + 100, 30, false);
draw_set_color(c_red);
draw_rectangle(10, 10, ((life/maxLife) * 100) + 100, 30, false);
draw_set_color(c_white);