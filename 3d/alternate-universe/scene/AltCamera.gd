extends Camera

export(NodePath) var follow_camera

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	follow_camera = get_node(follow_camera)
	set_process(true)
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	global_transform = follow_camera.global_transform
	pass
