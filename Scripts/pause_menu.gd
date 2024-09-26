extends CanvasLayer

func _on_resume_button_pressed():
	GameManager.resume_game()
	queue_free()



func _on_quit_button_pressed():
	GameManager.quit_game()


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	GameManager.restart_game()
	queue_free()
	
