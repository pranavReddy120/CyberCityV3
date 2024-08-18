extends Node
var world = preload("res://Scenes/level_1.tscn") 
var pause_menu = preload("res://Scenes/pause_menu.tscn")


func start_game(): 
	transition_to_scene(world.resource_path) #loads the world level

func quit_game(): 
	get_tree().quit()
	
func pause_game(): 
	get_tree().paused = true
	var pause_menu_instance = pause_menu.instantiate()
	get_tree().get_root().add_child(pause_menu_instance)

func resume_game(): 
	get_tree().paused = false

func transition_to_scene(scene_path): 
	#we could add a timer here if we wanted to have a loading screen with tips
	get_tree().change_scene_to_file(scene_path) #changes scene to parameter

