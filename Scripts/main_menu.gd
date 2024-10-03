extends CanvasLayer 
var level_menu = preload("res://Scenes/level_menu.tscn")
var level_1 = preload("res://Scenes/level_1.tscn")
var main_menu = preload("res://Scenes/main_menu.tscn")

func _on_play_button_pressed():
	GameManager.start_game(level_1.resource_path)
	

func _on_quit_button_pressed():
	GameManager.quit_game()
	 
 
func _on_level_button_pressed():
	GameManager.transition_to_scene(level_menu.resource_path)
