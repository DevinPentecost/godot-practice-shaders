shader_type canvas_item;

uniform float intensity : hint_range(0.0, 0.1);
uniform vec4 outline_color : hint_color;

void vertex() {
	
	//We want to grow the vertex
	VERTEX *= 1.0 + intensity;
}

void fragment() {
	//Get where this would be on the regular image
	vec2 new_uv = UV + ((UV - vec2(0.5)) * intensity);
	
	//Is this outside the original sprite?
	vec4 texture_color;
	if((new_uv.x < 0.0 || new_uv.x > 1.0) || (new_uv.y < 0.0 || new_uv.y > 1.0)){
		//We aren't a real color
		texture_color = vec4(0);
	}else{
		//We can just use the actual texture color at this position
		texture_color = texture(TEXTURE, new_uv);
	}
	
	//The 'outline', sampling the exploded sprite
	vec4 scaled_texture_color = texture(TEXTURE, UV);
	
	//Is there more 'outline' color than 'original' color?

	vec4 final_color;
	if(scaled_texture_color.a > texture_color.a){
		//We are in the outline zone
		final_color = outline_color;
	}else{
		//We are in the regular sprite
		final_color = texture_color;
	}
	/**
	if(texture_color.a >= scaled_texture_color.a){
		//We want to just show the regular
		final_color = texture_color;
	}
	else{
		//Do an outline
		//final_color = outline_color;
		final_color = vec4(scaled_texture_color.rgb, scaled_texture_color.a/5.0);
	}
	//If the scaled is full but not the texture, show an outline
	//If neither are full, show nothing...
	**/
	//We want to mix in the outline color based on this difference
	//vec3 mix_color = mix(texture_color.rgb, outline_color.xyz, alpha);
	
	//Draw the color
	COLOR = final_color;
}