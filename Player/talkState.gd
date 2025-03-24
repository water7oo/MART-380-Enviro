extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName
@onready var state_machine: LimboHSM = $LimboHSM

# Store references to the NPC and dialogue UI
var npc_parent: Node3D = null
# Rotation smoothing variables
var rotation_speed: float = 4.0   
var return_speed: float = 1.5    
var previous_rotation: Quaternion
var target_rotation: Quaternion


func _enter(npc: Node3D = null, dialogue: Control = null) -> void:
	print("Current State:", agent.state_machine.get_active_state())
	print("Entering Talk State")

	Global.can_move = false
	Global.is_talking = true

	# Store references passed from player2.gd
	npc_parent = Global.current_npc as Node3D

	if npc_parent:
		# Store the NPC's original rotation
		previous_rotation = npc_parent.global_transform.basis.get_rotation_quaternion()

		# Make the NPC face the player
		npc_parent.look_at(agent.global_transform.origin, Vector3.UP)
		npc_parent.rotate_y(PI)  
		target_rotation = npc_parent.global_transform.basis.get_rotation_quaternion()
		
		DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), "Start")


func _process(delta: float) -> void:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && Global.is_talking == true:
			print("leaving talking state")
			agent.state_machine.dispatch("to_idle")

func _exit() -> void:
	Global.can_move = true
	Global.is_talking = false
	# Reset NPC rotation
	if npc_parent:
		var tween := create_tween()
		tween.tween_property(npc_parent, "global_transform:basis", Basis(previous_rotation), return_speed) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Clear references
	npc_parent = null
