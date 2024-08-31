extends Label

func _process(delta):
	self.text = str(GameManager.reserve_ammo)
	pass 

