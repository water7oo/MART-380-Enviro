extends Node2D

@onready var animation_player = $AnimationPlayer  # Reference the AnimationPlayer node

func _process(delta: float) -> void:
	if Global.startGame:
		# Play the "Opener" animation only if it's not already playing
		if not animation_player.is_playing():
			animation_player.play("Opener")
	else:
		# Stop the animation if startGame is false
		animation_player.stop()


	if Global.is_final_boss == true || Global.ChosenOne == true:
		animation_player.play("Focused")
	else:
		animation_player.play("Reset Focused")
