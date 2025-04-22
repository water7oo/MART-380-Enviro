extends Node2D

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit_game"):
		print("Quit Game")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
func _ready():
	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/monominoStart.dialogue"), "start")
