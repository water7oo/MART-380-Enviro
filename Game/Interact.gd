extends Label



func _process(delta: float) -> void:
	if Global.is_near_npc:
		self.visible = true
	else:
		self.visible = false 
		pass
