shader_type canvas_item;

void fragment() {
	
	//We calculate the intensity of the inversion based on the alpha of the mask
	float intensity = texture(TEXTURE, UV).a;
	
	//Take a look at the screen
	vec4 screen_color = textureLod( SCREEN_TEXTURE, SCREEN_UV, 0.0);
	
	//Get the inverted color
	vec4 inverted_color = vec4(1.0 - screen_color.rgb, screen_color.a);
	
	//Do a lerp based on the intensity
	vec4 final_color = mix(screen_color, inverted_color, intensity);
	
	//Set the color
	COLOR = final_color;
	
}
