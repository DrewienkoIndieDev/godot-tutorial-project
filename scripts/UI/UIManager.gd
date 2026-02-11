extends Node

var interact_prompt: Control

func set_interact_prompt(prompt: Control):
	interact_prompt = prompt

func show_interact_prompt(text: String):
	if not interact_prompt:
		return
	interact_prompt.visible = true
	interact_prompt.set_text(text)

func hide_interact_prompt():
	if interact_prompt:
		interact_prompt.visible = false
