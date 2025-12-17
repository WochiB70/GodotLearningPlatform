extends CardState

var played:bool

func enter() -> void:
	played = false
	print("release", cardUI.targets)
	if not cardUI.targets.is_empty():
		print("使用卡片")
		played = true
		cardUI.play()

func on_input(_event:InputEvent) -> void:
	if played:
		return
		
	transition_requested.emit(self, CardState.State.BASE)
