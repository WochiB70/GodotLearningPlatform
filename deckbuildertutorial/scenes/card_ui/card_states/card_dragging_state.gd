extends CardState

const DRAG_MINIMUM_THRESHOLD = 0.05
var minimun_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		cardUI.reparent(ui_layer)
	
	cardUI.color.color = Color.NAVY_BLUE
	cardUI.state.text = "DRAGGING"
	
	minimun_drag_time_elapsed = false
	var threshold_time := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_time.timeout.connect(func():minimun_drag_time_elapsed = true)
	
func on_input(event:InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		cardUI.global_position = cardUI.get_global_mouse_position() - cardUI.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimun_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
