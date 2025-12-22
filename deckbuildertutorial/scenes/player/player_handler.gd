class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25

@export var hand: Hand

var charactor:CharactorStats

func _ready() -> void:
	Events.card_played.connect(_on_card_played)

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

func end_turn() -> void:
	hand.disable_hand()
	discard_cards()
	

func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_card(charactor.draw_pile.draw_card())
	reshuffle_deck_from_discard()
	
func draw_cards(amount:int) -> void:
	var tween := create_tween()
	for i in amount:
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func():Events.player_hand_drawn.emit()
	)


func discard_cards() -> void:
	print("丢弃卡片")
	var tween := create_tween()
	var children := hand.get_children()
	print(children)
	for card_ui in children:
		tween.tween_callback(charactor.discard.add_card.bind(card_ui.card))
		tween.tween_callback(hand.discard_card.bind(card_ui))
		tween.tween_interval(HAND_DISCARD_INTERVAL)
		
	tween.finished.connect(
		func(): Events.player_hand_discarded.emit()
	)
	print("丢弃卡片 完成")
	

func reshuffle_deck_from_discard() -> void:
	if not charactor.draw_pile.empty():
		return
	
	while not charactor.discard.empty():
		charactor.draw_pile.add_card(charactor.discard.draw_card())
	
	charactor.draw_pile.shuffle()

func _on_card_played(card:Card) -> void:
	charactor.discard.add_card(card)
