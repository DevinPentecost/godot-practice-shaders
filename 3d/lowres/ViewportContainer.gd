extends ViewportContainer
tool

export(float, 1, 10) var resolution_scale = 1 setget _set_resolution_scale


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass
	
func _update_shader():
	
	#Take the scale and give it to the material
	material.set_shader_param("resolution_scale", resolution_scale);
	


#Resolution was set
func _set_resolution_scale(new_resolution):
	
	#Set the variable
	resolution_scale = new_resolution
	_update_shader()
