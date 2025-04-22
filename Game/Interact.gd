extends Label



func _process(delta: float) -> void:
	if Global.is_near_npc:
		self.visible = true
	elif Global.isPainting1 || Global.isPainting2 || Global.isPainting3 || Global.isPainting4 || Global.isPainting5 || Global.isPainting6:
		self.visible = true
	else:
		self.visible = false 
		pass
