extends LimboState

@export var animation_player: AnimationPlayer
@export var animation: StringName
@onready var state_machine: LimboHSM = $LimboHSM

@onready var playerCharScene = $"../../RootNode/COWBOYPLAYER_V4"
@onready var animationTree = playerCharScene.find_child("AnimationTree", true)

@export var BASE_SPEED: float = Global.BASE_SPEED - 5
@export var DECELERATION: float = Global.DECELERATION - 5 

var preserved_velocity: Vector3 = Vector3.ZERO

func _enter() -> void:
	print("Current State:", agent.state_machine.get_active_state())
	# Preserve momentum when entering idle state
	preserved_velocity = agent.velocity

func _update(delta: float) -> void:
	player_idle(delta)
	initialize_jump(delta)
	initialize_crouch(delta)
	initialize_attack(delta)
	
	await get_tree().create_timer(.5).timeout
	Global.dialogue_just_ended = false
	# Check if the player can interact with the NPC and hasn't just ended dialogue
	if Global.is_near_npc and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
	elif Global.isPainting1 and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
	elif Global.isPainting2 and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
	elif Global.isPainting3 and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
	elif Global.isPainting4 and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
	elif Global.isPainting5 and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
	elif Global.isPainting6 and not Global.is_talking and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not Global.dialogue_just_ended:
		Global.is_talking = true
		Global.dialogue_just_ended = false  # Set flag to true to prevent re-triggering
		agent.state_machine.dispatch("to_talk")  # Enter talk state
func player_idle(delta: float) -> void:
	if Global.can_move:
		agent.move_and_slide()
		
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (agent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction.length() > 0 && Global.ChosenOne == false:
		# Player is moving, switch to walk state
		agent.velocity.x = direction.x * BASE_SPEED
		agent.velocity.z = direction.z * BASE_SPEED
		agent.state_machine.dispatch("to_walk")  
	else:
		# Apply sliding effect by gradually reducing velocity
		agent.velocity.x = move_toward(agent.velocity.x, 0, DECELERATION * delta)
		agent.velocity.z = move_toward(agent.velocity.z, 0, DECELERATION * delta)

		# Ensure the transition looks smooth
		Global.target_blend_amount = 0.0
		Global.current_blend_amount = lerp(Global.current_blend_amount, Global.target_blend_amount, Global.blend_lerp_speed * delta)
		animationTree.set("parameters/Ground_Blend/blend_amount", -1)
		
		

		
		
func initialize_jump(delta: float) -> void:
	if Input.is_action_just_pressed("move_jump"):
		agent.state_machine.dispatch("to_jump")
		
func initialize_crouch(delta: float) -> void:
	if Input.is_action_pressed("move_crouch"):
		agent.state_machine.dispatch("to_crouch")

func initialize_attack(delta: float) -> void:
	if Input.is_action_just_pressed("attack_light_1"):
		agent.state_machine.dispatch("to_attack")
