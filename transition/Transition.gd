tool
extends Sprite

export var threshold = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	var animation = $ThresholdAnimation.get_animation($ThresholdAnimation.current_animation)
	
	#Set the material value
	material.set_shader_param('threshold', threshold)
