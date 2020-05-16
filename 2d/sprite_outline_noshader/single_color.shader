shader_type canvas_item;

uniform vec4 target_color : hint_color;
uniform float alpha_threshold : hint_range(0, 1);

void fragment(){
    //Just draw it if it's within the threshold
    vec4 current_color = texture(TEXTURE, UV);
    if(current_color.a > alpha_threshold){
        //Draw it as the color
        COLOR = target_color;
    }else{
        //Draw nothing
        COLOR = vec4(0)
    }
}
