extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName
@onready var state_machine: LimboHSM = $LimboHSM

@onready var playerCharScene = $"../../RootNode/COWBOYPLAYER_V4"
@onready var animationTree = playerCharScene.find_child("AnimationTree", true)

# Variables for rotation smoothing
var target_rotation: float = 0.0
var npc_target_rotation: float = 0.0
var rotation_speed: float = 5.0  # Adjust for smoother or faster rotation

# Reference to the NPC
var npc_parent: Node3D

var camera: Camera3D = %Camera3D

func _enter() -> void:
	print("Current State:", agent.state_machine.get_active_state())
	Global.can_move = false
	Global.is_talking = true

	# Retrieve and cast the NPC reference
	npc_parent = Global.current_npc as Node3D  # Explicitly cast

	if npc_parent:
		# Get target direction towards the NPC
		var direction_to_npc = (npc_parent.global_transform.origin - agent.global_transform.origin).normalized()
		target_rotation = atan2(-direction_to_npc.x, -direction_to_npc.z)

		# Get target direction towards the player for NPC rotation
		var direction_to_player = (agent.global_transform.origin - npc_parent.global_transform.origin).normalized()
		npc_target_rotation = atan2(-direction_to_player.x, -direction_to_player.z)

		print("Rotating Player and NPC towards each other")
	else:
		print("No valid NPC reference found!")



func _process(delta: float) -> void:
	# Check if the NPC and pivot exist before accessing rotation
	if npc_parent != null:
		agent.rotation.y = lerp_angle(agent.rotation.y, target_rotation, rotation_speed * delta)

		# Rotate the spring arm pivot safely
		if Global.spring_arm_pivot != null:
			Global.spring_arm_pivot.rotation.y = lerp_angle(Global.spring_arm_pivot.rotation.y, target_rotation, rotation_speed * delta)

		# Rotate the NPC towards the player
		npc_parent.rotation.y = lerp_angle(npc_parent.rotation_degree.y, Global.camera.rotation_degree + 360, rotation_speed * delta)

		 
		# Debug output
		print("Player Rotation:", rad_to_deg(Global.camera.rotation_degree.y))
		print("NPC Rotation:", rad_to_deg(npc_parent.rotation.y))
	#else:
		#print("npc_parent is NULL!")  # Debug output
	

func _exit() -> void:
	Global.can_move = true
	Global.is_talking = false
	pass
