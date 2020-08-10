shader_type canvas_item;

//The mask (grayscale) to use for the transition
uniform sampler2D transition_mask;
uniform float threshold;

void fragment() {

	//We need to sample the mask
	vec4 mask_color = texture(transition_mask, UV);
	
	//Don't do anything by default
	vec4 color = texture(TEXTURE, UV);
	
	//Is the color below the threshold?
	if (mask_color.r < threshold) {
		//Instead use black
		color = vec4(0, 0, 0, 1)
	}
	
	//Set the color
	COLOR = color;

}
