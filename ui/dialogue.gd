extends Control

@onready var label: Label = $textBox/Label

# Controls visibility of the dialogue box
func _ready():
	hide()  # Hide by default

# Function to display dialogue
func show_dialogue(text: String) -> void:
	label.text = text
	show()

# Function to hide dialogue
func hide_dialogue() -> void:
	hide()
