shader_type canvas_item;

// We need three components
uniform sampler2D base;
uniform sampler2D hidden;
uniform sampler2D mask;
uniform float amount;

// Begin the fragment shader
void fragment() {
	
	//We always draw the base
	vec4 color = texture(base, UV);
	
	//Shift the mask based on time
	float mask_offset = sin(TIME) * amount;
	vec2 sample_point = vec2(UV.x + mask_offset, UV.y);
	
	//Sample the mask
	vec4 mask_color = texture(mask, sample_point);
	
	//How dark is it? Assuming greyscale, just use R
	float intensity = 1.0 - mask_color.r;
	
	//Interpolate the hidden color based on that
	vec4 hidden_color = texture(hidden, UV);
	hidden_color = mix(color, hidden_color, hidden_color.a);
	color = mix(color, hidden_color, intensity);
	
	//Use the color
	COLOR = color;
}