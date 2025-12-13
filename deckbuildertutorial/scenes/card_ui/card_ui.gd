class_name CardUI

extends Control

signal reparent_requested(which_card_ui: CardUI)

@export var card: Card

@onready var color: ColorRect = $Color
@onready var drop_point_dectetor: Area2D = $DropPointDectetor
@onready var state: Label = $State
@onready var cardStateMachine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var target:Array[Node] = []

var parent: Control
var tween: Tween


func _ready() -> void:
	cardStateMachine.init(self)
	
func _input(event: InputEvent)  -> void:
	cardStateMachine.on_input(event)
	
func animate_to_position(new_position:Vector2, duration:float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

func _on_mouse_entered() -> void:
	cardStateMachine.on_mouse_entered();
	
func _on_mouse_exited() -> void:
	cardStateMachine.on_mouse_exited();

func _on_gui_input(event: InputEvent) -> void:
	cardStateMachine.on_gui_input(event)


func _on_drop_point_dectetor_area_entered(area: Area2D) -> void:
	if not target.has(area):
		target.append(area)


func _on_drop_point_dectetor_area_exited(area: Area2D) -> void:
	target.erase(area)
