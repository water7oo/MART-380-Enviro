extends Node


func _ready():
	var scene = get_tree().current_scene
	if scene:
		print("Current scene name: ", scene.name)

		if scene.name == "HEAVEN":
			Global.isInHeaven = true
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/hStartGame.dialogue"), "start")
		elif scene.name == "HELL":
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/StartGame.dialogue"), "start")

	
func _process(delta):
	pass
