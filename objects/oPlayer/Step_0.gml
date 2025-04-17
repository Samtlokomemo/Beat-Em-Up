event_inherited();
state();
Parallax();

if life < 0 {life = 0}

if(is_struct(myDmg)){
    myDmg.update_area();
}

if(life <= 0){
    state = StateDeath;
}
