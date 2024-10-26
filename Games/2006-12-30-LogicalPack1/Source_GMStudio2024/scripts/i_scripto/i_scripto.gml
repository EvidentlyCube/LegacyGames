function i_scripto() {
	if global.level=0{clipboard_set_text("BEGINNING!")}
	if global.level=1{clipboard_set_text("LEARNING?!")}
	if global.level=2{clipboard_set_text("GIVEITBEST")}
	if global.level=3{clipboard_set_text("ROCKNROLL!")}
	if global.level=4{clipboard_set_text("YUMMY_EH??")}
	if global.level=5{clipboard_set_text("EASY_ROOMY")}
	if global.level=6{clipboard_set_text("FLYFARAWAY")}
	if global.level=7{clipboard_set_text("BREAK_THIS")}
	if global.level=8{clipboard_set_text("GO_GO_GO_!")}
	if global.level=9{clipboard_set_text("LEARN_N_GO")}
	if global.level=10{clipboard_set_text("STILL_HERE")}
	if global.level=11{clipboard_set_text("FEEL_POWER")}
	if global.level=12{clipboard_set_text("GO_FOR_IT!")}
	if global.level=13{clipboard_set_text("BLACK_BLUE")}
	if global.level=14{clipboard_set_text("WALL_FALL!")}
	if global.level=15{clipboard_set_text("BLUMP_JUMP")}
	if global.level=16{clipboard_set_text("FILL_KILL!")}
	if global.level=17{clipboard_set_text("GOOD_LUCK!")}
	if global.level=18{clipboard_set_text("EIGHTEEN!!")}
	if global.level=19{clipboard_set_text("MORE_TO_GO")}
	if global.level=20{clipboard_set_text("TWO_ZERO_!")}
	if global.level=21{clipboard_set_text("---!--!---")}
	if global.level=22{clipboard_set_text("ITS_TIRING")}
	if global.level=23{clipboard_set_text("GET_LOST??")}
	if global.level=24{clipboard_set_text("FLUFFY....")}
	if global.level=25{clipboard_set_text("..MACHINAE")}
	if global.level=26{clipboard_set_text("RHAPSODY_-")}
	if global.level=27{clipboard_set_text("BLIND_SPOT")}
	if global.level=28{clipboard_set_text("GOOD_MOOD?")}
	if global.level=29{clipboard_set_text("BLAH_BLAH!")}
	if global.level=30{clipboard_set_text("NOTHINGNES")}
	if global.level=31{clipboard_set_text("ZANGBAND!!")}
	if global.level=32{clipboard_set_text("TOME_HACK!")}
	if global.level=33{clipboard_set_text("BACK_UP!!!")}
	if global.level=34{clipboard_set_text("FIGHT_NOW!")}
	if global.level=35{clipboard_set_text("ABCDEFGIJZ")}
	if global.level=36{clipboard_set_text("IENXNEKFIE")}
	if global.level=37{clipboard_set_text("1232343456")}
	if global.level=38{clipboard_set_text("666?_NOPE!")}
	if global.level=39{clipboard_set_text("2536475869")}
	if global.level=40{clipboard_set_text("A7HW8HUD5=")}
	if global.level=41{clipboard_set_text("a2+2a2=3a2")}
	if global.level=42{clipboard_set_text("JEDI?YETI!")}
	if global.level=43{clipboard_set_text("LOLO:P:P:P")}
	if global.level=44{clipboard_set_text("IF_THEN_X!")}
	if global.level=45{clipboard_set_text("BEND_TO...")}
	if global.level=46{clipboard_set_text("..SEE_END!")}
	if global.level=47{clipboard_set_text("FAR_TO_END")}
	if global.level=48{clipboard_set_text("ALMOST_END")}
	if global.level=49{clipboard_set_text("WTF?_END?!")}
	if global.level=50{clipboard_set_text("OMFG!END!!")}
	ini_open("passwords.txt")
	ini_write_string("Toggler","Level "+string(global.level),clipboard_get_text())
	ini_close()



}
