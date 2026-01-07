class_name CharactorStats
extends Stats

@export var starting_deck:CardPile
@export var card_per_trun:int
@export var max_mana: int


var mana: int: set = set_mana
var deck: CardPile
var discard:CardPile
var draw_pile:CardPile

func set_mana(value: int) -> void:
	mana = value
	statss_changed.emit()

func reset_mana() -> void:
	mana = max_mana

func can_play_card(card: Card) -> bool:
	return mana >= card.cost

func take_damage(damage:int) -> void:
	var initial_health := health
	super.take_damage(damage)
	if initial_health > health:
		Events.player_hit.emit()

func create_instance() -> Resource:
	var instance: CharactorStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate()
	instance.discard = CardPile.new()
	instance.draw_pile = CardPile.new()
	return instance
