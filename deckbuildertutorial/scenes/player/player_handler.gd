class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.25

@export var hand: Hand

var charactor:CharactorStats

func start_battle(char_stats: CharactorStats) -> void:
	charactor = char_stats
	charactor.draw_pile = charactor.deck.duplicate(true)
	charactor.draw_pile.shuffle()
	charactor.discard = CardPile.new()
	start_turn()
	
func start_turn() -> void:
	charactor.block = 0
	charactor.reset_mana()
	draw_cards(charactor.card_per_trun)

func draw_card() -> void:
	hand.add_card(charactor.draw_pile.draw_card())
	
func draw_cards(amount:int) -> void:
	var tween := create_tween()
	for i in amount:
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func():Events.player_hand_drawn.emit()
	)
