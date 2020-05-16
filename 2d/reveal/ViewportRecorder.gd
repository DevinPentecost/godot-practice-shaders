extends Node

#The viewport to record
export(String, DIR) var target_directory = "./recordings/"
var target_viewport = null
var image_index = 0
var scene_name = null

func _ready():
	#Get the active viewport for recording
	#TODO: Allow for user-specified viewports
	target_viewport = get_viewport()
	
	#Reset the image index for naming
	image_index = 0
	
	#Get the current scene name
	scene_name = get_tree().get_current_scene().get_name()
	
	#Process every frame
	set_process(true)
	
	pass

func _process(delta):
	#We want to get the viewport's image data
	var texture = target_viewport.get_texture()
	
	#Get the image data for this texture
	var image = texture.get_data()
	
	#Now build the file path
	var file_path = target_directory + "image_" + str(image_index) + ".png"
	image_index += 1
	
	#Write the image to that file
	var result = image.save_png(file_path)
	print("Recording... " + str(result))
