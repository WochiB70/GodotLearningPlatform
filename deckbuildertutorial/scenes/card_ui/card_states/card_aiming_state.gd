extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD := 130


func enter() -> void:
	cardUI.color.color = Color.WEB_PURPLE
	cardUI.state.text = "AIMING"
	cardUI.target.clear()
	print("进入aiming状态，此时得target数组为",cardUI.target)
	var offset := Vector2(cardUI.parent.size.x / 2, -cardUI.size.y / 2)
	offset.x -= cardUI.size.x / 2
	cardUI.animate_to_position(cardUI.parent.global_position + offset, 0.2)
	cardUI.drop_point_dectetor.monitoring = false
	Events.card_aim_started.emit(cardUI)
	
func exit() -> void:
	Events.card_aim_ended.emit(cardUI)
	

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var mouse_at_bottom := cardUI.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD

	if (mouse_motion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
		
