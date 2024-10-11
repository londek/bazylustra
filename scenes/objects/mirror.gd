class_name Mirror
extends StaticBody2D

@export var rotation_fake := 0
@export var arr: PackedVector2Array
@export var highlighted: bool = false

@onready var sprite: Sprite2D = $Sprite2D

var img = [preload("res://assets/mirror/mirror_front.png"), 
preload("res://assets/mirror/mirror_front_right.png"), 
preload("res://assets/mirror/mirror_right.png"),
preload("res://assets/mirror/mirror_back_right.png"),
preload("res://assets/mirror/mirror_back.png"), 
preload("res://assets/mirror/mirror_back_left.png"),
preload("res://assets/mirror/mirror_left.png"),
preload("res://assets/mirror/mirror_front_left.png")]

var step := 360 / img.size()

func _ready() -> void:
	sprite.texture = img[rotation_fake % 360 / step]

func _process(delta: float) -> void:
	sprite.texture = img[rotation_fake % 360 / step]
	
	sprite.modulate == Color(120, 120, 120, 1)
