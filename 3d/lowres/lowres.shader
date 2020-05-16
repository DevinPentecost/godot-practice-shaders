shader_type canvas_item;


//How much to upscale by
uniform float resolution_scale : hint_range(1, 10);

void fragment(){
	
	//If we are 1:1, don't do anything
	if(resolution_scale == 1.0){
		COLOR = texture(TEXTURE, UV);
	}else{
		//We want to scale the image down
	
		//Step every Nth pixel, where N is the scale

		//Convert the UV into texture coordinates
		vec2 texture_size = vec2(textureSize(TEXTURE, 1));
		vec2 uv_pixels = UV * texture_size;
		
		//Divide the pixels by the scale and floor to get the whole-number step count
		vec2 step_count = floor(uv_pixels / resolution_scale);
		
		//Now we want to sample at the step count as opposed to the usual UV
		vec2 new_uv_pixels = step_count * resolution_scale;
		vec2 new_uv = new_uv_pixels / texture_size;
		
		//Sample this new position
		vec4 color = texture(TEXTURE, new_uv);
		
		//Use the color
		COLOR = color;
	}	
}
