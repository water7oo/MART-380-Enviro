extends Node3D


func _process(delta: float) -> void:
	$AnimationPlayer.play("IDLE")
