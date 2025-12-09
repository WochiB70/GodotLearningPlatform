extends CardState


func enter() -> void:
	cardUI.color.color = Color.ORANGE
	cardUI.state.text = "CLICKED"
	cardUI.drop_point_dectetor.monitoring = true
	
func on_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGIN)
