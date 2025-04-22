extends Label3D

@export var npc_label = Node3D

func _ready():
	var scene = get_tree().current_scene
	if scene:

		if scene.name == "HEAVEN":
			npc_label.text = "SAVIOR"
		elif scene.name == "HELL":
			npc_label.text = "CRYBABY"

	
