class_name ManaUI
extends Panel

@export var char_stats: CharactorStats: set = set_char_stats

@onready var mana_label: Label = $ManaLabel

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	char_stats.mana = 2

func set_char_stats(value: CharactorStats) -> void:
	char_stats = value
	
	if not char_stats.statss_changed.is_connected(on_stats_changed):
		char_stats.statss_changed.connect(on_stats_changed)
		
	if not is_node_ready():
		await ready
	on_stats_changed()
	
func on_stats_changed() -> void:
	mana_label.text = "%s/%s" % [char_stats.mana, char_stats.max_mana]
