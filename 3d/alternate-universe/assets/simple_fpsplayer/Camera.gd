extends Camera

var MOUSESPEED = 0.005
#For some reason the movement won't work properly without this.
func _input(event):
	if event is InputEventMouseMotion:
		rotation.x = clamp(rotation.x - event.relative.y*MOUSESPEED, deg2rad(-90), deg2rad(90))