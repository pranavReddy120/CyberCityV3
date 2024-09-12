extends CanvasLayer
var main_menu = preload("res://Scenes/main_menu.tscn")


func _on_resume_button_pressed():
	GameManager.resume_game()
	queue_free()



func _on_quit_button_pressed():
	GameManager.transition_to_scene(main_menu.resource_path)


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	GameManager.resume_game()
	queue_free()
