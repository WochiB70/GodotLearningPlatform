extends CardState


func enter() -> void:
	if not cardUI.is_node_ready():
		await cardUI.ready
	
	cardUI.panel.set("theme_override_styles/panel", cardUI.BASE_STYLEBOX)
	
	
	cardUI.reparent_requested.emit(cardUI)
	cardUI.pivot_offset = Vector2.ZERO
	
func on_gui_input(event: InputEvent) -> void:
	if not cardUI.playable or cardUI.disabled:
		return
	
	if event.is_action_pressed("left_mouse"):
		cardUI.pivot_offset = cardUI.get_global_mouse_position() - cardUI.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_enter() -> void:
	if not cardUI.playable or cardUI.disabled:
		return
	cardUI.panel.set("theme_override_styles/panel", cardUI.HOVER_STYLEBOX)


func on_mouse_exit() -> void:
	if not cardUI.playable or cardUI.disabled:
		return
	cardUI.panel.set("theme_override_styles/panel", cardUI.BASE_STYLEBOX)
