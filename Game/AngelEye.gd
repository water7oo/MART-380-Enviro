extends Area3D


func _on_area_entered(area):
	if area.name == "PlayerDialogue":
		Global.can_move = false
		Global.isAngelsFree = true
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/angelEyes.dialogue"), "start")
	
	
	if DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/angelEyes.dialogue"), "end"):
		Global.can_move = true

func _on_dialogue_ended(resource):
	print("Dialogue ended:", resource)

	# Only set the flag to true if the final boss dialogue ends
	if resource.resource_path == "res://Dialogue/angelEyes.dialogue":
		Global.isAngelsFree = true
		Global.can_move = true
