extends Area3D

@export var camera = $"../Preview/SubViewportContainer/SubViewport/CameraSet"
@export var finalBossCutsceneMarker = $"../FinalBossCam"
@onready var scaryLights2 = get_node("../OmniLight3D2")  # Correcting reference to the light
@onready var gameJuice = get_node("/root/GameJuice")
@onready var enemy = get_node("/root/EnemyHealthManager")
@export var target: NodePath
@export var speed := 1.0
@export var enabled: bool
@export var spring_arm_pivot: Node3D
@export var mouse_sensitivity: float = 0.005
@export var joystick_sensitivity: float = 0.005 
var cam_lerp_speed: float = .005

@onready var scaryNoise2 = $ScaryNoise2

var is_mouse_visible: bool = true

@export var period: float = .04
@export var magnitude: float = 0.08

@export var y_cam_rot_dist: float = -80
@export var x_cam_rot_dist: float = 1



var original_global_transform: Transform3D
var target_node: Node3D

func _ready() -> void:
	# Connect the dialogue_ended signal to a custom function
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _process(delta: float) -> void:
	pass

func _on_area_entered(area):
	if area.name == "PlayerDialogue":
		
		if Global.pleaseGiveKeys:
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/ChosenOne2dialogue.dialogue"), "start")
		else:
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/ChosenOnedialogue.dialogue"), "start")
		Global.can_move = false
		Global.ChosenOne = true
		
		await get_tree().create_timer(2).timeout
		
		scaryNoise2.play()
		scaryLights2.visible = true  # Show the scary lights

func _on_dialogue_ended(resource):
	# This function will trigger when dialogue ends
	print("Dialogue ended:", resource)
	scaryLights2.visible = false  # Hide the scary lights
	Global.can_move = true
	scaryNoise2.play()
	Global.ChosenOne = false
	
