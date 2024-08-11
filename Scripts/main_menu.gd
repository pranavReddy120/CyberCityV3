class_name MainMenu
extends Control

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play_Game as Button
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Quit_Game as Button
@onready var start_level = preload("res://Scenes/world.tscn") as PackedScene

#func _ready():
	#play_button.pressed.connect(_on_play_game_pressed())
	#quit_button.pressed.connect(_on_quit_game_pressed())
	
func _on_play_game_pressed():
	get_tree().change_scene_to_packed(start_level)


func _on_quit_game_pressed():
	get_tree().quit() #quits game on button click
