if !can_exit { exit }

czoczmen=file_text_open_write(program_directory + "/Game_Finished.txt")
file_text_write_string(czoczmen,"If you want to see the game end screen again please delete this file and play game - it won't work if you have deleted your savefile")
file_text_close(czoczmen)
global.finished=2
part_system_clear(ps)
part_system_destroy(ps)

url_open("https://www.evidentlycube.com")
game_end()
