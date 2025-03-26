extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName
@onready var state_machine: LimboHSM = $LimboHSM

# Store references to the NPC and dialogue UI
var npc_parent: Node3D = null
var rotation_speed: float = 4.0   
var return_speed: float = 1.5    
var previous_rotation: Quaternion
var target_rotation: Quaternion

func _enter(npc: Node3D = null, dialogue: Control = null) -> void:
	print("Current State:", agent.state_machine.get_active_state())

	Global.can_move = false
	Global.is_talking = true
	Global.dialogue_just_ended = false  # Reset the flag to allow future interactions

	npc_parent = Global.current_npc as Node3D

	if npc_parent:
		# Save the NPC's current rotation
		previous_rotation = npc_parent.global_transform.basis.get_rotation_quaternion()
		npc_parent.look_at(agent.global_transform.origin, Vector3.UP)
		npc_parent.rotate_y(PI)  
		target_rotation = npc_parent.global_transform.basis.get_rotation_quaternion()
		
		# Connect to the dialogue_ended signal
		if not DialogueManager.dialogue_ended.is_connected(_on_dialogue_ended):
			DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
		
		# Choose the dialogue based on the 'pleaseGiveKeys' condition
		if Global.pleaseGiveKeys:
			
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/AfterFinalBossNPC.dialogue"), "start")
		else:
			DialogueManager.show_example_dialogue_balloon(load("res://Dialogue/main.dialogue"), "Start")
	

func _process(delta: float) -> void:
	pass

func _exit() -> void:
	Global.can_move = true
	Global.is_talking = false

	if npc_parent:
		# Smoothly return NPC to previous rotation
		var current_rotation = npc_parent.rotation
		var tween := create_tween()
		tween.tween_property(npc_parent, "rotation:y", previous_rotation.get_euler().y, return_speed) \
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	npc_parent = null
	print('LEAVING STATE')

# Handle dialogue ending
func _on_dialogue_ended(resource):
	print("Dialogue ended:", resource)
	Global.can_move = true
	Global.is_talking = false
	Global.dialogue_just_ended = true  # Set flag to true once the dialogue ends
	# Return to idle state after dialogue
	agent.state_machine.dispatch("to_idle")
