extends CardState


func enter() -> void:
	cardUI.drop_point_dectetor.monitoring = true
	cardUI.original_index = cardUI.get_index()
	
func on_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGIN)
