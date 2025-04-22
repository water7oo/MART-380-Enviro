extends CharacterBody3D

@export var state_machine: LimboHSM = $LimboHSM
@export var idle_state = $LimboHSM/IdleState
@export var walk_state = $LimboHSM/WalkState
@export var jump_state = $LimboHSM/JumpState 
@export var run_state = $LimboHSM/RunState
@export var runJump_state = $LimboHSM/RunJumpState
@export var burst_state = $LimboHSM/BurstState
@export var crouch_state = $LimboHSM/CrouchState
@export var groundDive_state = $LimboHSM/GroundDiveState
@export var airDive_state = $LimboHSM/AirDiveState
@export var slide_state = $LimboHSM/SlideState
@export var talk_state = $LimboHSM/TalkState


@export var take_damage_state = $LimboHSM/TakeDamageState
@export var recover_state = $LimboHSM/RecoverState

var talkNPC = Input.is_action_pressed("NPC")



func _ready():
	initialize_state_machine()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func initialize_state_machine():
	state_machine.add_transition(state_machine.ANYSTATE, idle_state, "to_idle")
	state_machine.add_transition(state_machine.ANYSTATE, walk_state, "to_walk")
	state_machine.add_transition(state_machine.ANYSTATE, run_state, "to_run")
	state_machine.add_transition(state_machine.ANYSTATE, jump_state, "to_jump")
	state_machine.add_transition(state_machine.ANYSTATE, take_damage_state, "to_damaged")
	state_machine.add_transition(state_machine.ANYSTATE, talk_state, "to_talk")

	
	state_machine.add_transition(run_state, runJump_state, "to_runJump")
	state_machine.add_transition(walk_state, burst_state, "to_burst")
	state_machine.add_transition(run_state, burst_state, "to_burst")
	
	state_machine.add_transition(idle_state, crouch_state, "to_crouch")
	state_machine.add_transition(run_state, crouch_state, "to_crouch")
	state_machine.add_transition(walk_state, crouch_state, "to_crouch")
	
	
	state_machine.add_transition(take_damage_state, recover_state, "to_recover")


	state_machine.initial_state = idle_state  
	state_machine.initialize(self)
	state_machine.set_active(true)
	
	

	
func playerCamera(delta: float) -> void:
	pass

func playerGravity(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= Global.CUSTOM_GRAVITY * delta





func _on_hurt_box_area_exited(area):
	pass # Replace with function body.


func _on_attack_box_area_entered(area):
	pass # Replace with function body.



func _on_hurt_box_area_entered(area):
	if area.name == "enemyBox":
		Global.last_enemy_hit = area.get_parent()  # Set the enemy that hit the player

		# Optionally, transition to TakeDamage state
		state_machine.dispatch("to_damaged")


func _on_attack_box_area_exited(area):
	pass # Replace with function body.



func _on_dialogue_npc_area_entered(area):
	if area.name == "DialogueNPC1" && !Global.is_talking:
		print("Entered NPC Area")
		Global.is_near_npc = true
		Global.current_npc = area.get_parent() as Node3D
	elif area.name == "Paint1Area" && !Global.is_talking:
		print("Player is in front of painting")
		Global.isPainting1 = true
	elif area.name == "Paint2Area" && !Global.is_talking:
		print("Player is in front of painting")
		Global.isPainting2 = true
	elif area.name == "Paint3Area" && !Global.is_talking:
		print("Player is in front of painting")
		Global.isPainting3 = true
	elif area.name == "Paint4Area" && !Global.is_talking:
		print("Player is in front of painting")
		Global.isPainting4 = true
		
	elif area.name == "Paint5Area" && !Global.is_talking:
		print("Player is in front of painting")
		Global.isPainting5 = true
	elif area.name == "Paint6Area" && !Global.is_talking:
		print("Player is in front of painting")
		Global.isPainting6 = true



func _on_dialogue_npc_area_exited(area):
	if area.name == "DialogueNPC1":
		print("Exited NPC Area")
		Global.is_near_npc = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference
	elif area.name == "Paint1Area":
		print("Exited NPC Area")
		Global.isPainting1 = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference
	elif area.name == "Paint2Area":
		print("Exited NPC Area")
		Global.isPainting2 = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference
	elif area.name == "Paint3Area":
		print("Exited NPC Area")
		Global.isPainting3 = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference
	elif area.name == "Paint4Area":
		print("Exited NPC Area")
		Global.isPainting4 = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference
	elif area.name == "Paint5Area":
		print("Exited NPC Area")
		Global.isPainting5 = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference
	elif area.name == "Paint6Area":
		print("Exited NPC Area")
		Global.isPainting6 = false
		Global.is_talking = false
		Global.current_npc = null  # Clear the NPC reference

func _physics_process(delta: float) -> void:
	playerGravity(delta)
	#print(Global.isAngelsFree)
	
	#print(Global.is_near_npc)
	


func _on_leaving_heaven_area_entered(area):
	pass # Replace with function body.
