class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state:CardState
var states := {}


func init(card: CardUI) -> void:
	print(get_children())
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.cardUI = card
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

	
func on_input(event:InputEvent) -> void:
	if current_state != null:
		current_state.on_input(event)
		
func on_gui_input(event:InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered() -> void:
	if current_state:
		current_state.enter()
	
func on_mouse_exited() -> void:
	if current_state:
		current_state.exit()

func _on_transition_requested(from:CardState, to :CardState.State) -> void:
	if current_state != from:
		return
	var new_state:CardState = states[to]
	
	if not new_state:
		return
		
	new_state.enter()
	current_state = new_state
