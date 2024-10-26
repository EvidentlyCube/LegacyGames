/// @description Insert description here
// You can write your code in this editor

var layer_id = layer_create(0, "default");
instance_create_layer(-201, -9, layer_id, Master)
instance_create_layer(0,0, layer_id, Player)
	
for (var i = 0; i < array_length(global.prop_sets); i++) {
    var obj_id = global.prop_sets[i][0];
	var prop = global.prop_sets[i][1];
	var value = global.prop_sets[i][2];
	
	if (prop = "$SPECIAL") {
	    switch(value[0]) {
			case("Buttons_Get_Special"):
				Buttons_Get_Special(obj_id, value[1]);
				break;
			default:
				show_message("ERROR: Unknown special action '" + value[0] + "'");
				break;
		}
	} else {
		variable_instance_set(obj_id, prop, value);
	}
}

//Master_Create()