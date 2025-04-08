switch (buttonID) {
	case 0: //Jogar
        layer_destroy("MenuInicial")
        room_goto(rmFase1)
		
    break;
    case 1: //Opções
        layer_set_visible("MenuOpcoes", true);
        if(layer_exists("MenuInicial")){
            layer_set_visible("MenuInicial", false);
        }
        layer_set_visible("MenuPausa", false);
    break;
    case 2: //Sair
        game_end()
    break;
    case 3: //Voltar
        layer_set_visible("MenuOpcoes", false);
		if(room == menu){
			 layer_set_visible("MenuInicial", true);
		}else if(room == rmFase1){
			layer_set_visible("MenuPausa", true);
		}
    break;
	case 5: //Continuar
		oPause.pause = false;
		oPause.updatePause();
	break;
}