extends Label3D


func _process(delta: float) -> void:
	$AnimationPlayer.play("floatingInteract")
	if Global.is_near_npc:
		self.visible = true
	else:
		self.visible = false
