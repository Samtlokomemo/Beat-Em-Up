if (keyboard_check_pressed(vk_down)) {
    menu_position = (menu_position + 1) mod array_length(menu_control[menu_index]);
}

if (keyboard_check_pressed(vk_up)) {
    menu_position = (menu_position - 1 + array_length(menu_control[menu_index])) mod array_length(menu_control[menu_index]);
}

if (keyboard_check_pressed(vk_enter)) {
    var selected_item = menu_control[menu_index][menu_position];

    switch (selected_item) {
        case "Jogar":
            room_goto_next();
            break;
        case "Opções":
            menu_index = 1;
            menu_position = 0;
            break;
        case "Sair":
            game_end();
            break;
        case "Som":
            menu_index = 2; 
            menu_position = 0;
            break;
        case "Controles":
            menu_index = 3;
            menu_position = 0;
            break;
        case "Voltar":
            menu_index = 0;
            menu_position = 0;
            break;
    }
}