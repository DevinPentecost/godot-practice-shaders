shader_type canvas_item;

uniform float intensity : hint_range(0.0, 0.2);
uniform vec4 inline_color : hint_color;

void fragment() {
	
	//Sample at this UV
	vec4 texture_color = texture(TEXTURE, UV);
	
	//Sample an area further out to simulate 'shrinking'
	vec2 new_uv = UV + ((UV - vec2(0.5)) * intensity);
	
	//The 'outline', sampling the shrunk sprite. If we are too far, just be nothing
	vec4 scaled_texture_color;
	if((new_uv.x < 0.0 || new_uv.x > 1.0) || (new_uv.y < 0.0 || new_uv.y > 1.0)){
		scaled_texture_color = vec4(0);
	}else{
		//Sample at this spot
		scaled_texture_color = texture(TEXTURE, new_uv);
	}
	//If we see regular texture but not the scaled tex, then we do the inline
	vec4 final_color = texture_color;
	if(texture_color.a > scaled_texture_color.a){
		//We are in the inline zone
		final_color = inline_color;
	}
	
	//Draw the color
	COLOR = final_color;
}
