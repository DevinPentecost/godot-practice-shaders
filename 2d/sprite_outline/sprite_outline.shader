shader_type canvas_item;

uniform float intensity : hint_range(0.0, 0.03);
uniform vec4 outline_color : hint_color;

void vertex() {
	
	//We want to grow the vertex
	VERTEX *= 1.0 + intensity;
	
	
	//VERTEX += vec2(1.0, 1.0);
}

void fragment() {
	//Get the regular UV color
	vec4 texture_color = texture(TEXTURE, UV);
	
	//Draw the color
	COLOR = texture_color;
}