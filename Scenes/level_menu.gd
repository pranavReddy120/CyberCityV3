extends CanvasLayer
var level_1 = preload("res://Scenes/level_1.tscn")
var level_2 = preload("res://Scenes/level_2.tscn")
var boss_level = preload("res://Scenes/Boss_level.tscn")
var main_menu = preload("res://Scenes/main_menu.tscn")


func _on_level_1_pressed():
	GameManager.transition_to_scene(level_1.resource_path)
	GameManager.start_game(level_1.resource_path)


func _on_level_2_pressed():
	GameManager.transition_to_scene(level_2.resource_path)
	GameManager.start_game(level_2.resource_path)


func _on_boss_level_pressed():
	GameManager.transition_to_scene(boss_level.resource_path)
	GameManager.start_game(boss_level.resource_path)


func _on_main_pressed():
	GameManager.transition_to_scene(main_menu.resource_path)
