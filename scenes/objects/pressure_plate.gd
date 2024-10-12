extends Area2D


@export var spikes: Array[Spike]

@onready var sprite_2d: Sprite2D = $Sprite2D

const PLATE_DOWN_GOLD = preload("res://assets/objects/plate_down_gold.png")
const PLATE_UP_GOLD = preload("res://assets/objects/plate_up_gold.png")

var pressed: bool = false:
	set(val):
		pressed = val
		sprite_2d.texture = PLATE_DOWN_GOLD if pressed else PLATE_UP_GOLD

func _on_body_entered(body: Node2D) -> void:
	if body is Rat:
		pressed = true
	call_deferred("switch_spikes")


func _on_body_exited(body: Node2D) -> void:
	if body is Rat:
		pressed = false
	call_deferred("switch_spikes")


func switch_spikes() -> void:
	for spike in spikes:
		spike.switch()
