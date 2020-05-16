shader_type canvas_item;

//The mask to use (usually a cloud)
uniform sampler2D fade_mask;

//Where we currently are on the fade
uniform float amount: hint_range(0.0, 1.0);

//The color to fade to when disappearing
uniform vec4 fade_color: hint_color;

//How long before the fade to start changing the color
uniform float fade_threshold: hint_range(0.05, 0.01);

//How long to hold the color before fading away
uniform float color_hold = 0.05;
uniform float color_fade = 0.02;

//An upper clamp to make sure that full black is invisible
uniform float color_clamp = 0.99;

void fragment(){
	
	//Sample the fade mask
	vec4 mask_color = texture(fade_mask, UV);
	
	//Get the greyscale color
	float intensity = mask_color.r;
	
	//Adjust the intensity to stay in the range
	float full_clamp = color_clamp - color_hold - color_fade;
	intensity = intensity * full_clamp;

	//Get the color of the image
	vec4 texture_color = texture(TEXTURE, UV);
	
	//Are we within the threshold?
	if(amount > intensity + color_hold + color_fade){
		//We are done, show nothing
		texture_color = vec4(0.0);
	}else if(amount > intensity + color_hold){
		//We have held the color and it is time to fade away
		//Fade the color away
		float fade_amount = (amount - intensity - color_hold) / color_fade;
		texture_color = mix(texture_color, vec4(0.0), fade_amount);
	} else if(amount > intensity){
		//Hold the color
		texture_color.rgb = fade_color.rgb;
	} else if(amount > intensity - fade_threshold){
		//Start fading towards that color
		float mix_amount = (amount - intensity) / (fade_threshold);
		texture_color.rgb = mix(texture_color.rgb, fade_color.rgb, mix_amount);
	} else{
		//Use the texture color normally
	}
	
	//Set the color
	COLOR = texture_color;
}
