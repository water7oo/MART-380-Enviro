extends Node3D

func _process(delta: float) -> void:
	if Global.endGame:
		Global.can_move = false
		DialogueManager.show_example_dialogue_balloon(load("res://gameOverdialogue.dialogue"), "start")
