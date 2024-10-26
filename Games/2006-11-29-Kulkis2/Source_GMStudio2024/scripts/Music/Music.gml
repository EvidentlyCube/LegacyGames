// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function smart_music_play(_audio){
	if audio_is_paused(_audio) {
		audio_resume_sound(_audio);
	} else if !audio_is_playing(_audio){
		audio_play_sound(_audio, 1, true);
	}
}

function smart_music_pause() {
	var _types = [
		music_easy,
		music_extreme,
		music_hard,
		music_level_select,
		music_logic,
		music_title,
		music_win,
		music_tutorial
	];
	
	for (var _i = 0; _i < array_length(_types); _i++) {
		var _type = _types[_i];
		
		if audio_is_playing(_type) {
			audio_pause_sound(_type);
		}
	}
}