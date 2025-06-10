alpha = .8 * (1 - exp(-.005 * (100 - oPlayer.life)))
if(global.eventos >= 3 and !instance_exists(oEnemy)){
    //GG
    room_goto(rmWin)
}