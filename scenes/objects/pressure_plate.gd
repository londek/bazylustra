extends Area2D


@export var spikes: Array[Spike]

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var sprite: Texture
@export var sprite_pressed: Texture


var pressed: bool = false:
	set(val):
		pressed = val
		sprite_2d.texture = sprite_pressed if pressed else sprite


func _on_body_entered(body: Node2D) -> void:
	if body is Rat:
		if body.is_stoned:
			pressed = true
			call_deferred("switch_spikes")


func _on_body_exited(body: Node2D) -> void:
	if body is Rat:
		pressed = false
	call_deferred("switch_spikes")


func switch_spikes() -> void:
	for spike in spikes:
		spike.switch()
