extends Node

#Global Variables 
@onready var playerHealthMan = get_node("/root/PlayerHealthManager")
@onready var enemyHealthMan = get_node("/root/EnemyHealthManager")
@onready var gameJuice = get_node("/root/GameJuice")

@export var CUSTOM_GRAVITY: float = 35.0
var camera: Node3D = preload("res://Player/PlayerCamera.tscn").instantiate()
var spring_arm_pivot = camera.get_node("SpringArmPivot")
var spring_arm = camera.get_node("SpringArmPivot/SpringArm3D")
var is_talking: bool = false
var current_blend_amount: float = 0.0
var target_blend_amount: float = 0.0
var blend_lerp_speed: float = 10.0 
var is_near_npc: bool = false
var current_npc: Node3D = null
var last_grounded_position: Vector3 = Vector3.ZERO
var is_final_boss: bool = false
var is_mouse_visible: bool = true
var dialogue_just_ended = false
var pleaseGiveKeys = false
var ChosenOne = false
var startGame = false
var tryingtoEscape = false
var isPainting1: bool = false
var isPainting2: bool = false
var isPainting3: bool = false
var isPainting4: bool = false
var isPainting5: bool = false
var isPainting6: bool = false
var isInHeaven: bool = false
var isAngelsFree:bool = false


var endGame = false
@export var mouse_sensitivity: float = 0.005

@export var armature_rot_speed: float = 1
@export var armature_default_rot_speed: float = 1
@onready var armature = $Armature_001
var game_paused = false

#Walk State Base movement values
@export var BASE_SPEED: float = 6.0
@export var MAX_SPEED: float = 10.0  # Reduce slightly for better control
@export var ACCELERATION: float = 40.0  # Slightly higher for snappier movement
@export var DECELERATION: float = 25.0  # Increase for quicker stopping
@export var BASE_DECELERATION: float = 20.0  # Matches normal deceleration
@export var momentum_deceleration: float = DECELERATION - 5
@export var momentum_acceleration: float = ACCELERATION + 10
@export var inertia_blend: float = 7

@export var run_inertia_blend: float = inertia_blend/1.5

@export var run_momentum_acceleration: float = momentum_acceleration - 2
@export var run_momentum_deceleration: float = momentum_deceleration - 2
@export var air_momentum_acceleration: float = momentum_acceleration - 2
@export var air_momentum_deceleration: float = momentum_deceleration - 2

var can_move: bool = true
var last_enemy_hit = null

#Jump State Base movement values:
@export var JUMP_VELOCITY: float = 11.0  
