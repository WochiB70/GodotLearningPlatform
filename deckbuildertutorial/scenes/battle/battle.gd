extends Node2D

@export var char_stats: CharactorStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler

func _ready() -> void:
	var new_stats: CharactorStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	
	start_battle(new_stats)
	
func start_battle(stats: CharactorStats) -> void:
	player_handler.start_battle(stats)
