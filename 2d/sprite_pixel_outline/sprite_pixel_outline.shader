shader_type canvas_item;

uniform float outline_intensity;
uniform vec4 outline_color : hint_color;

void vertex(){
	//We need to increase the size of everything
	VERTEX *= 1.0 + outline_intensity;
}

void fragment(){
	
	//Get where this would be on the regular image
	vec2 regular_uv = UV + ((UV - vec2(0.5)) * outline_intensity);
	
	//Is this outside the original sprite?
	vec4 regular_color = texture(TEXTURE, regular_uv);
	if((regular_uv.x < 0.0 || regular_uv.x > 1.0) || (regular_uv.y < 0.0 || regular_uv.y > 1.0)){
		//We aren't a real color
		regular_color = vec4(0);
	}
	
	//Now we need to sample pixels on either side of this one, depending on the intensity
	vec4 final_color = regular_color;
	for(int x = -1; x <= 1; x += 2){
		for(int y = -1; y <= 1; y += 2){
			//Get the X and Y offset from this
			vec2 outline_uv = regular_uv + vec2(float(x)*outline_intensity, float(y)*outline_intensity);
			
			//Sample here, if we are out of bounds then fail
			vec4 outline_sample = texture(TEXTURE, outline_uv);
			if((outline_uv.x < 0.0 || outline_uv.x > 1.0) || (outline_uv.y < 0.0 || outline_uv.y > 1.0)){
				//We aren't a real color
				outline_sample = vec4(0);
			}
			
			//Is our sample empty? Is there something nearby?
			if(outline_sample.a > final_color.a){
				final_color = outline_color;
			}
		}
	}
	
	//Use the final color
	COLOR = final_color;
}
