extends CardState

var played:bool

func enter() -> void:
	played = false
	
	if not cardUI.target.is_empty():
		played = true
		

func on_input(event:InputEvent) -> void:
	if played:
		return
		
	transition_requested.emit(self, CardState.State.BASE)
