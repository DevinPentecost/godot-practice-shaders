shader_type canvas_item;

uniform float outline_intensity : hint_range(0.0, 0.1);
uniform vec4 outline_color : hint_color;
uniform float inline_intensity : hint_range(0.0, 0.2);
uniform vec4 inline_color : hint_color;

void vertex() {
	//Expand the sprite to contain the outline
	VERTEX *= 1.0 + outline_intensity;
	
}

vec4 regular_texture(sampler2D regular_texture, vec2 regular_uv){
	//Get the color
	vec4 regular_color = texture(regular_texture, regular_uv);
	
	//If we are out of bounds, return nothing
	if((regular_uv.x < 0.0 || regular_uv.x > 1.0) || (regular_uv.y < 0.0 || regular_uv.y > 1.0)){
		//We aren't a real color
		regular_color = vec4(0);
	}
	
	//Return the color we sampled
	return regular_color;
}

vec4 inner_texture(sampler2D regular_texture, vec2 regular_uv){
	//Get the 'shrunk' UV
	vec2 inner_uv = regular_uv + ((regular_uv - vec2(0.5)) * inline_intensity);
	
	//Sample the color
	vec4 inner_color = texture(regular_texture, inner_uv);
	
	//Are we out of bounds?
	if((inner_uv.x < 0.0 || inner_uv.x > 1.0) || (inner_uv.y < 0.0 || inner_uv.y > 1.0)){
		//We aren't a real color
		inner_color = vec4(0);
	}
	
	//Return the final value
	return inner_color;
}

void fragment() {
	
	//Get the color in the 'outline' zone
	vec4 outer_color = texture(TEXTURE, UV);
	
	//Firstly, we need to scale back down to 'regular size'
	vec2 normal_uv = UV + ((UV - vec2(0.5)) * outline_intensity);
	
	//Get the color of this at the 'normal' location
	vec4 regular_color = regular_texture(TEXTURE, normal_uv);

	//Get the color for the inside
	vec4 inner_color = inner_texture(TEXTURE, normal_uv);

	//We have three colors - the outer, the regular, and the inner
	vec4 final_color = regular_color;
	
	//If we see an outer but not regular, we are the outline
	if(outer_color.a > regular_color.a){
		//We are part of the outline
		final_color = outline_color;
	}else if(regular_color.a > inner_color.a){
		//We have the regular sprite but not the inside one
		//We are part of the inline
		final_color = inline_color;
	}
	
	//Draw the color
	COLOR = final_color;
	
}
