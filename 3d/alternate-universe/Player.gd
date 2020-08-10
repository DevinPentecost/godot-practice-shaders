extends KinematicBody

var movement = {
	KEY_W: false,
	KEY_A: false,
	KEY_S: false,
	KEY_D: false,
}

var speed = 1 #unit per second

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	set_process_input(true)
	set_process(true)
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	#Update position based on movement
	var move_magnitude = speed * delta
	var move_vector = Vector3(move_magnitude, 0, 0)
	if movement[KEY_W]:
		move_and_collide(move_vector)
	
	pass

func _unhandled_input(event):
	
	#Which key was it
	if event is InputEventKey and movement.has(event.scancode):
		movement[event.scancode] = event.pressed
	