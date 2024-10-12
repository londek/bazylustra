extends Area2D


@export var spikes: Array[Spike]

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var sprite: Texture
@export var sprite_pressed: Texture

var rats_on_plate: Array[Rat]


var pressed: bool = false:
	set(val):
		sprite_2d.texture = sprite_pressed if pressed else sprite
		if pressed != val:
			call_deferred("switch_spikes")
		pressed = val


func _on_body_entered(body: Node2D) -> void:
	if body is Rat:
		print("ajojdafiowjd")
		if !(body in rats_on_plate):
			rats_on_plate.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body in rats_on_plate:
		rats_on_plate.erase(body)


func _process(delta: float) -> void:
	if rats_on_plate.size():
		for rat in rats_on_plate:
			if rat.is_stoned:
				pressed = true


func switch_spikes() -> void:
	for spike in spikes:
		spike.switch()
