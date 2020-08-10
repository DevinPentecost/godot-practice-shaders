extends KinematicBody
#Variables
var global = "root/global"

var X = 0.00
var Y = 0.00

var speed = 5
var gravity = -9.8
var moving = true
var MOUSESPEED = 0.005
var JUMP_VEL = 12
var jumping = false

onready var playerfeet = get_node("playerfeet")
onready var camera = get_node("Camera")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_physics_process(true)
	set_process_input(true)

func _input(event):
	# For Mouse Look. The Camera node has a script for the X rotation.
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x*MOUSESPEED
	# Function to close game.
	if Input.is_key_pressed(KEY_ESCAPE) or Input.is_key_pressed(KEY_Q):
		get_tree().quit()

func _process(delta):
	var is_on_ground = playerfeet.is_colliding()
	var on_top = playerfeet.get_collider()
	move_and_collide(Vector3(0, gravity*delta, 0))
	#Section for basic movement.
	if Input.is_key_pressed(KEY_W):
		translate(Vector3(0, 0, speed*delta))
	if Input.is_key_pressed(KEY_S):
		translate(Vector3(0, 0, -speed*delta))
	if Input.is_key_pressed(KEY_A):
		translate(Vector3(speed*delta, 0, 0))
	if Input.is_key_pressed(KEY_D):
		translate(Vector3(-speed*delta, 0, 0))
