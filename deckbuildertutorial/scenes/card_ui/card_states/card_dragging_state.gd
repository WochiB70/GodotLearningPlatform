extends CardState

const DRAG_MINIMUM_THRESHOLD = 0.05
var minimun_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		cardUI.reparent(ui_layer)
	
	cardUI.panel.set("theme_override_styles/panel", cardUI.DRAG_STYLEBOX)
	Events.card_drag_started.emit(cardUI)
	
	minimun_drag_time_elapsed = false
	var threshold_time := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_time.timeout.connect(func():minimun_drag_time_elapsed = true)

func exit() -> void:
	Events.card_drag_ended.emit(cardUI)

func on_input(event:InputEvent) -> void:
	var single_targeted := cardUI.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel: bool  = event.is_action_pressed("right_mouse")
	var confirm: bool = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if single_targeted and mouse_motion and cardUI.targets.size() > 0:
		print("进入Aiming状态")
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion:
		cardUI.global_position = cardUI.get_global_mouse_position() - cardUI.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minimun_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
