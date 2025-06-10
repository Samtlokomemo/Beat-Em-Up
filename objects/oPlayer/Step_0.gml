event_inherited();
state();
Parallax();
second_attack_cd--;

if life < 0 {life = 0}

if(life <= 0){
    state = StateDeath;
}
