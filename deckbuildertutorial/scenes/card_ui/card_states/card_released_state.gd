extends CardState

var played:bool

func enter() -> void:
	cardUI.color.color = Color.DARK_VIOLET
	cardUI.state.text = "RELEASED"
	played = false
	
	if not cardUI.target.is_empty():
		played = true
		print("使用卡片", cardUI.target)
		

func on_input(event:InputEvent) -> void:
	if played:
		return
		
	transition_requested.emit(self, CardState.State.BASE)
