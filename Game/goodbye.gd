extends Area3D


func _on_area_entered(area):
	if area.name == "PlayerDialogue":
		get_tree().change_scene_to_file("res://start_menu.tscn")
		print("Die")
