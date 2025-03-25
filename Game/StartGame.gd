extends Area3D

func _ready() -> void:
	# Connect the dialogue_ended signal to a custom function
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _process(delta: float) -> void:
	pass

func _on_area_entered(area):
	if area.name == "PlayerDialogue":
		Global.can_move = false
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/StartGame.dialogue"), "start")

func _on_dialogue_ended(resource):
	# This function will trigger when dialogue ends
	print("Dialogue ended:", resource)
	Global.can_move = true
