extends Area3D
@export var camera = $"../Preview/SubViewportContainer/SubViewport/CameraSet"
@export var finalBossCutsceneMarker = $"../FinalBossCam"
@onready var gameJuice = get_node("/root/GameJuice")
@onready var enemy = get_node("/root/EnemyHealthManager")
@export var target: NodePath
@export var speed := 1.0
@export var enabled: bool
@export var spring_arm_pivot: Node3D
@export var mouse_sensitivity: float = 0.005
@export var joystick_sensitivity: float = 0.005 
var cam_lerp_speed: float = .005

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
		Global.can_move = false
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/FinalBoss.dialogue"), "start")
		Global.is_final_boss = true

func _on_dialogue_ended(resource):
	# This function will trigger when dialogue ends
	print("Dialogue ended:", resource)
	Global.can_move = true
	Global.is_final_boss = false
