extends Control

@onready var label: Label = $Label

func _ready():
	UiManager.set_interact_prompt(self)
	visible = false

func set_text(text: String):
	label.text = text
