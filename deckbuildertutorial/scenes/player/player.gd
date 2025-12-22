class_name Player
extends Node2D

@export var stats: CharactorStats : set = set_charactor_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI

func set_charactor_stats(value: CharactorStats) -> void:
	stats = value
	
	if not stats.statss_changed.is_connected(update_stats):
		stats.statss_changed.connect(update_stats)
	
	update_player()

func update_player() -> void:
	if not stats is CharactorStats:
		return
	
	if not is_inside_tree():
		await  ready
	
	sprite_2d.texture = stats.art
	update_stats()

func update_stats() -> void:
	stats_ui.update_stats(stats)

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return 
	stats.take_damage(damage)
	
	if stats.health <= 0:
		queue_free()
