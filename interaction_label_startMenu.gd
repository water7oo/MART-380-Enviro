extends Node

@onready var labelRight: Label3D = $"../Preview/SubViewportContainer/interactionLabelR"
@onready var labelLeft: Label3D = $"../Preview/SubViewportContainer/interactionLabelL"

@onready var AnimationPlayerR = $"../Preview/SubViewportContainer/interactionLabelR/AnimationPlayer"
@onready var AnimationPlayerL = $"../Preview/SubViewportContainer/interactionLabelL/AnimationPlayer2"

@onready var heavenPlayer = $"../Preview/SubViewportContainer/Heaven/AnimationPlayer"
@onready var hellPlayer = $"../Preview/SubViewportContainer/Hell/AnimationPlayer"

@onready var hellLight = $"../Preview/SubViewportContainer/SubViewport/Hell"
@onready var heavenLight = $"../Preview/SubViewportContainer/SubViewport/Heaven"

var selected: String = ""  # either "left" or "right"

func _ready():
	labelRight.visible = false
	labelLeft.visible = false
	hellLight.visible = false
	heavenLight.visible = false
	
	if not DialogueManager.dialogue_ended.is_connected(_on_dialogue_ended):
		DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


	DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/monominoStart.dialogue"), "start")
	
func _process(delta: float) -> void:
	AnimationPlayerR.play("Hover")
	AnimationPlayerL.play("Hover2")
	
	if Input.is_action_just_pressed("move_right"):
		labelRight.visible = true
		labelLeft.visible = false
		heavenPlayer.play("Shrink")
		hellPlayer.play("Grow")
		print_debug("menu move right")
		$"../Scarynoise1".play()
		hellLight.visible = true
		heavenLight.visible = false
		selected = "right"
		
	elif Input.is_action_just_pressed("move_left"):
		labelRight.visible = false
		labelLeft.visible = true
		heavenPlayer.play("Grow")
		hellPlayer.play("Shrink")
		print_debug("menu move left")
		$"../Scarynoise1".play()
		hellLight.visible = false
		heavenLight.visible = true
		selected = "left"

	# Confirm selection
	if Input.is_action_just_pressed("move_jump") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if selected == "right":
			get_tree().change_scene_to_file("res://Game/DevRoomGame.tscn")

		elif selected == "left":
			get_tree().change_scene_to_file("res://Game/DevRoomGame2.tscn")

func _on_dialogue_ended(resource):
	print("Dialogue ended:", resource)
	Global.can_move = true
	Global.is_talking = false
	Global.dialogue_just_ended = true  # Set flag to true once the dialogue ends
	# Return to idle state after dialogue
