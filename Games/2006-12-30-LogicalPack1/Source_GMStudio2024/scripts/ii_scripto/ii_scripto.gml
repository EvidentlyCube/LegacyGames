function ii_scripto() {
	if global.level=00{clipboard_set_text("BRINGITON!")}
	if global.level=01{clipboard_set_text("BURNINHELL")}
	if global.level=02{clipboard_set_text("FLYTHAROS!")}
	if global.level=03{clipboard_set_text("RHAPSODY..")}
	if global.level=04{clipboard_set_text("...ON_FIRE")}
	if global.level=05{clipboard_set_text("FREEDOM...")}
	if global.level=06{clipboard_set_text("...CALL!!!")}
	if global.level=07{clipboard_set_text("HAMMERFALL")}
	if global.level=08{clipboard_set_text("E-TYPE!!!!")}
	if global.level=09{clipboard_set_text("NIGHTWISH!")}
	if global.level=10{clipboard_set_text("HACK_SIGN!")}
	if global.level=11{clipboard_set_text("NARUTO!!!!")}
	if global.level=12{clipboard_set_text("FALLEN_ONE")}
	if global.level=13{clipboard_set_text("BLOODYHELL")}
	if global.level=14{clipboard_set_text("RANDOMPASS")}
	if global.level=15{clipboard_set_text("RANDOMLASS")}
	if global.level=16{clipboard_set_text("BUZZASTRAL")}
	if global.level=17{clipboard_set_text("TOY_STORY!")}
	if global.level=18{clipboard_set_text("GREEN_MILE")}
	if global.level=19{clipboard_set_text("BLAH_IS_XY")}
	if global.level=20{clipboard_set_text("IFGOTOTHEN")}
	if global.level=21{clipboard_set_text("LOLLIES...")}
	if global.level=22{clipboard_set_text("...HATE...")}
	if global.level=23{clipboard_set_text(".SERIOUS..")}
	if global.level=24{clipboard_set_text("...SAM_2!!")}
	if global.level=25{clipboard_set_text("BLAHBLAHX2")}
	if global.level=26{clipboard_set_text("TRALALAOLA")}
	if global.level=27{clipboard_set_text("D83H4FH4X9")}
	if global.level=28{clipboard_set_text("CP348FRI35")}
	if global.level=29{clipboard_set_text("VMDIOS48GD")}
	if global.level=30{clipboard_set_text("6I9502G824")}
	if global.level=31{clipboard_set_text("VG_3N4_G8G")}
	if global.level=32{clipboard_set_text("FGN84F38F9")}
	if global.level=33{clipboard_set_text("DARTHVADER")}
	if global.level=34{clipboard_set_text("ILIKECHIKS")}
	if global.level=35{clipboard_set_text("GROUP_X_!_")}
	if global.level=36{clipboard_set_text("MYSLOVITZ!")}
	if global.level=37{clipboard_set_text("BLAH_HASDW")}
	if global.level=38{clipboard_set_text("ZEAIRXYNTX")}
	if global.level=39{clipboard_set_text("CAPTAINLOL")}
	if global.level=40{clipboard_set_text("BLUE_BASE!")}
	if global.level=41{clipboard_set_text("SHARPNEL!!")}
	if global.level=42{clipboard_set_text("JAPANMUSIC")}
	if global.level=43{clipboard_set_text("SOMELEVEL!")}
	if global.level=44{clipboard_set_text("BLA_UND_HA")}
	if global.level=45{clipboard_set_text("PLAYTOYXXL")}
	if global.level=46{clipboard_set_text("FLUFFYMAGS")}
	if global.level=47{clipboard_set_text("DAREORDEAR")}
	if global.level=48{clipboard_set_text("THEEARTROX")}
	if global.level=49{clipboard_set_text("OVEREDGAME")}
	if global.level=50{clipboard_set_text("ROTFLOLXD!")}
	ini_open("passwords.txt")
	ini_write_string("Carder","Level "+string(global.level),clipboard_get_text())
	ini_close()



}
