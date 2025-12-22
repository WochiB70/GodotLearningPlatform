class_name BattleUI
extends CanvasLayer

@export var char_stats: CharactorStats: set = _set_stats

@onready var hand: Hand = $Hand as Hand
@onready var mana_ui: ManaUI = $ManaUI as ManaUI

func _set_stats(value: CharactorStats) -> void:
	char_stats = value
	mana_ui.char_stats = char_stats
	hand.char_stats = char_stats
