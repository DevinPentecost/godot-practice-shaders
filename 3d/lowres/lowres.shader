shader_type canvas_item;

//How much to upscale by
uniform float resolution_scale : hint_range(1, 10);

void fragment(){
	
	//We want to scale the image down
	
	//Step every Nth pixel, where N is the scale
	
	//Normalize the scale
	float scale_normalized = resolution_scale / 10.0;
	float step_size = scale_normalized / 100.0;
	
	//We need to take steps based on the resolution scale
	//How many steps to take?
	float steps_x = floor((UV.x / step_size));
	float steps_y = floor((UV.y / step_size));
	
	//Sample that new step
	float new_x = (steps_x * step_size);
	float new_y = (steps_y * step_size);
	
	//Build the new UV
	vec2 new_uv = vec2(new_x, new_y);
	
	//Sample this new position
	vec4 color = texture(TEXTURE, new_uv);
	
	//Use the color
	COLOR = color;
	
}