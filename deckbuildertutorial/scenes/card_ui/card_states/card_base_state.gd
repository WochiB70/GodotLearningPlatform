extends CardState


func enter() -> void:
	if not cardUI.is_node_ready():
		await cardUI.ready
		
	cardUI.reparent_requested.emit(cardUI)
	cardUI.color.color = Color.WEB_GREEN
	cardUI.state.text = "BASE"
	cardUI.pivot_offset = Vector2.ZERO
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		cardUI.pivot_offset = cardUI.get_global_mouse_position() - cardUI.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
