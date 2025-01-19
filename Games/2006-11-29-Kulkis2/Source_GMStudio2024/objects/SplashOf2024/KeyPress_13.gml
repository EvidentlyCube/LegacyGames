var file = file_text_open_write(program_directory + "/.post-splash");
file_text_write_string(file, "Hello curious soul!\nThis was my first big game and it has a special place in my heart. It's not the best of games and it's a stretch to call it designed but I love it.\nPlease appreciate it just a little!");
file_text_close(file);
room_goto(Intron);