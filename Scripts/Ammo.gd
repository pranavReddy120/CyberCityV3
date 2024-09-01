extends Label


func _process(delta):
	self.text = str(GameManager.current_ammo)
	pass 
