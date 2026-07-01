extends Node

enum UIMode {
	NONE,
	DIALOGUE_AMBIENT,
	DIALOGUE_LOCKED,
}

var interact_prompt: Control
var mouse_captured : bool = false
var active_modes: Array[UIMode] = []


# ----------------------- MODE MANAGEMENT -----------------------------


func push_mode(mode: UIMode):
	if mode in active_modes:
		return
	active_modes.append(mode)
	_update_ui_state()

func pop_mode(mode: UIMode):
	active_modes.erase(mode)
	_update_ui_state()


func has_mode(mode: UIMode) -> bool:
	return mode in active_modes

func is_dialogue_active() -> bool:
	return has_mode(UIMode.DIALOGUE_AMBIENT) or has_mode(UIMode.DIALOGUE_LOCKED)

func is_dialogue_locked() -> bool:
	return has_mode(UIMode.DIALOGUE_LOCKED)


# ----------------------- INTERACT PROMPT -----------------------------


func set_interact_prompt(prompt: Control):
	interact_prompt = prompt

func show_interact_prompt(text: String):
	if not interact_prompt:
		return
	if is_dialogue_locked():
		return
	interact_prompt.visible = true
	interact_prompt.set_text(text)

func hide_interact_prompt():
	if interact_prompt:
		interact_prompt.visible = false


# ----------------------- MOUSE -----------------------------

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true


func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
	

# ----------------------- OTHER -----------------------------

func _update_ui_state():
	if is_dialogue_locked():
		hide_interact_prompt()
		release_mouse()
	
	elif not is_dialogue_locked():
		capture_mouse()
	
func reset():
	active_modes.clear()
	hide_interact_prompt()
