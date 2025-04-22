extends Label3D


func _process(delta: float) -> void:
	$AnimationPlayer.play("floatingInteract")
	if Global.isPainting4:
		self.visible = true
	else:
		self.visible = false
