extends Sprite
tool

#Simple class to automatically create an 'outline' sprite
var outline_shader = preload("res://2d/sprite_outline_noshader/single_color.shader")

#Color and size
export(Color) var outline_color = Color(1, 0, 1)
export(float, 0, 1) var outline_size = 0.1 setget _set_outline_size #Percentage of size, not pixel count. Having a size less than 1 is pointless
export(float, 0, 1) var outline_threshold = 0.1

#The sprite we use to make the outline
var outline_sprite = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	#Make the simple outline
	_initialize_outline()
	_update_outline()
	
	pass
	
func _initialize_outline():
	#Simply make a new sprite that's identical to this one
	var new_sprite = duplicate()
	new_sprite.position = Vector2(0, 0)
	
	#Give it a specific shader to just draw the outline
	var new_material = ShaderMaterial.new()
	new_material.shader = outline_shader
	new_sprite.material = new_material
	
	#Add the new sprite but without the script
	new_sprite.show_behind_parent = true
	new_sprite.set_script(null)
	outline_sprite = new_sprite
	add_child(new_sprite)
	
func _set_outline_size(new_size):
	#Set the size
	outline_size = new_size
	
	#Update the outline
	_update_outline()
	
func _update_outline():
	
	#Do we have the outline sprite?
	if outline_sprite:
		#Make it a little bigger
		var new_scale = 1 + outline_size
		outline_sprite.scale = Vector2(new_scale, new_scale)
		
		#Update the color and threshold
		outline_sprite.material.set_shader_param("target_color", outline_color)
		outline_sprite.material.set_shader_param("alpha_threshold", outline_threshold)
	