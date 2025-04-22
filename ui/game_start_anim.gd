extends Node2D

@onready var animation_player = $AnimationPlayer  # Reference the AnimationPlayer node

@onready var animation_player2 = $ColorRect/AnimationPlayer2
func _ready():
	
	#var scene = get_tree().current_scene
	if get_tree().current_scene.name == "HEAVEN" || get_tree().current_scene.name == "HELL" || get_tree().current_scene.name == "STARTGAME":
		print("start opening animation")
		if not animation_player.is_playing():
			animation_player.play("Opener")
			
		if not animation_player2.is_playing():
			animation_player2.play("FADE IN")
	
	#else:
		## Stop the animation if startGame is false
		#animation_player.stop()
#
#
	#if Global.is_final_boss == true || Global.ChosenOne == true:
		#animation_player.play("Focused")
	#else:
		#animation_player.play("Reset Focused")
