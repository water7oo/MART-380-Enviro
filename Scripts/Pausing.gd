class_name Pausing
extends Node3D




func _process(delta):
	pause_game(delta)
	
	#if Input.is_action_just_pressed("quit_game"):
		#get_tree().quit()
		
	
	

func pause_game(delta):
	if Input.is_action_just_pressed("pause_button"):
		if Global.game_paused:
			print_debug("Unpausing game")
			get_tree().paused = false
			$PAUSEMENU.visible = false
			Global.game_paused = false
			
			# Reset mouse mode after unpausing
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  
		else:
			print_debug("Pausing game")
			get_tree().paused = true
			$PAUSEMENU.visible = true
			Global.game_paused = true
			
			# Show the mouse when paused
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_area_3d_area_entered(area):
	pass # Replace with function body.
