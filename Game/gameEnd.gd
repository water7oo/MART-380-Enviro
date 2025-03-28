extends Node3D

#func _process(delta: float)-> void:
	#if Global.tryingtoEscape:
		#print("game over")
		#get_tree().reload_current_scene()
