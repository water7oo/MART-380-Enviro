extends Label3D


func _process(delta: float) -> void:
	$AnimationPlayer.play("floatingInteract")
	if Global.isPainting1:
		self.visible = true
	else:
		self.visible = false
