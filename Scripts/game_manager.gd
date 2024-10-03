extends Node
var level_1 = preload("res://Scenes/level_1.tscn") 
var pause_menu = preload("res://Scenes/pause_menu.tscn")
var level_2 = preload("res://Scenes/level_2.tscn")
var boss_level = preload("res://Scenes/boss_level.tscn")
var level_menu = preload("res://Scenes/level_menu.tscn")
var max_ammo = 10 
var current_ammo = max_ammo
var max_reserve = 20
var reserve_ammo = 20

func start_game(scene_path): 
	transition_to_scene(scene_path) #loads the world level
	resume_game()

func quit_game(): 
	get_tree().quit()
	
func pause_game(): 
	get_tree().paused = true
	var pause_menu_instance = pause_menu.instantiate()
	get_tree().get_root().add_child(pause_menu_instance)

func resume_game(): 
	get_tree().paused = false

func restart_game(): 
	current_ammo = max_ammo
	reserve_ammo = max_reserve
	get_tree().paused = false

func transition_to_scene(scene_path): 
	#we could add a timer here if we wanted to have a loading screen with tips
	get_tree().change_scene_to_file(scene_path) #changes scene to parameter

