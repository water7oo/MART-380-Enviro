extends Area3D

@export var camera = $"../Preview/SubViewportContainer/SubViewport/CameraSet"
@onready var bgm = get_node("../BGM")
@onready var player = get_node("../Preview/SubViewportContainer/SubViewport/Cowboy")
@export var finalBossCutsceneMarker = $"../FinalBossCam"
@onready var scaryLights = get_node("../OmniLight3D")  # Correcting reference to the light
@onready var gameJuice = get_node("/root/GameJuice")
@onready var enemy = get_node("/root/EnemyHealthManager")
@export var target: NodePath
@export var speed := 1.0
@export var enabled: bool
@export var spring_arm_pivot: Node3D
@export var mouse_sensitivity: float = 0.005
@export var joystick_sensitivity: float = 0.005 
var cam_lerp_speed: float = .005

@onready var scaryNoise1 = $Scarynoise1

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
	#print("check keys" + str(Global.pleaseGiveKeys))
	pass

func _on_area_entered(area):
	if area.name == "PlayerDialogue":
		Global.can_move = false
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/FinalBoss2.dialogue"), "start")
		Global.is_final_boss = true
		Global.tryingtoEscape = true
		bgm.stop()

		
		await get_tree().create_timer(2).timeout
		
		scaryNoise1.play()
		scaryLights.visible = true  # Show the scary lights

func _on_dialogue_ended(resource):
	print("Dialogue ended:", resource)

	# Only set the flag to true if the final boss dialogue ends
	if resource.resource_path == "res://Dialogue/FinalBoss.dialogue":
		print("Final Boss dialogue ended!")
		Global.pleaseGiveKeys = true

	scaryLights.visible = false  # Hide the scary lights
	Global.can_move = true
	scaryNoise1.play()
	bgm.play()
	Global.is_final_boss = false
	Global.tryingtoEscape = false
	
