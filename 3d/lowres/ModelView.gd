extends Viewport

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	#Get the resolution and match
	#Get the width and height of the display from the parent viewport
	var window_size = OS.get_real_window_size()
	size = window_size
	print(window_size)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
