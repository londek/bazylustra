class_name Spike
extends StaticBody2D


@onready var polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var sprite: Texture
@export var sprite_hid: Texture
@export var enabled: bool = false


func _ready() -> void:
	switch()


func switch():
	enabled = !enabled
	sprite_2d.texture = sprite if enabled else sprite_hid
	polygon.disabled = !enabled
