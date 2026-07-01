extends Node

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.Choices.question_shown.connect(_on_question_shown)
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_timeline_started():
	var mode = Dialogic.VAR.get_variable("global.dialogue_mode")
	
	if mode == "ambient":
		UiManager.push_mode(UiManager.UIMode.DIALOGUE_AMBIENT)
		UiManager.capture_mouse()
	else:
		UiManager.push_mode(UiManager.UIMode.DIALOGUE_LOCKED)
		UiManager.release_mouse()


func _on_timeline_ended():
	UiManager.pop_mode(UiManager.UIMode.DIALOGUE_AMBIENT)
	UiManager.pop_mode(UiManager.UIMode.DIALOGUE_LOCKED)


func _on_question_shown(_info: Dictionary):
	UiManager.release_mouse()


func _on_dialogic_signal(argument: String):
	if argument == "print":
		print("THIS IS A SIGNAL!")


func start_dialogue(timeline_name: String, mode: String = "ambient"):
	if UiManager.is_dialogue_active():
		return
	Dialogic.VAR.set_variable("global.dialogue_mode", mode)
	Dialogic.start(timeline_name)
