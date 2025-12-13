class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state:CardState
var states := {}


func init(card: CardUI) -> void:
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
		current_state.on_mouse_enter()
	
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exit()

func _on_transition_requested(from:CardState, to :CardState.State) -> void:
	# 1. 判断状态的初始状态是否与当前状态一致 (或 状态未更改 这部分可以根据需要设定)
	if current_state != from or current_state.state == to:
		return
	
	# 2. 判断将要转入的状态是否存在状态机可用合集中
	if !states.has(to):
		# 不存在 返回false
		return
		
	# 3. 退出当前状态
	current_state.exit()
	
	# 4. 更变当前状态的引用 
	# 更变的引用需要从状态机可用集合中提取
	current_state = states[to]
	
	# 5. 进入新状态
	current_state.enter()
