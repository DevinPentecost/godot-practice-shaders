shader_type spatial;

//Ignore lighting/shading, also tell it to do an additive blend
render_mode unshaded, blend_add;

//What color to use for the overdraw?
uniform vec4 overdraw_color : hint_color;

void vertex()
{
	//Adjust the vertex color with the overdraw color
	COLOR *= overdraw_color;
}

void fragment()
{
	//Set the albedo to be the overdraw color's RGB
	ALBEDO = overdraw_color.rgb;
}