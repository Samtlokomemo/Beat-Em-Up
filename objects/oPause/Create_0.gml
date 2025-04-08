pause = false;
layerName = "MenuPausa";

function updatePause(){
	if(pause){
		instance_deactivate_all(true);
		layer_set_visible(layerName, true);
	}else{
		instance_activate_all()
		layer_set_visible(layerName, false);
	}
}

updatePause();