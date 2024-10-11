class_name Mirror
extends StaticBody2D

@export var rotation_fake := 0
@export var arr: PackedVector2Array
@export var highlighted: bool = false:
	set(val):
		highlighted = val
		sprite.modulate = Color(0.5, 0.5, 0.5, 0.5) if val else Color(1, 1, 1, 1)

@onready var sprite: Sprite2D = $Sprite2D
@onready var blocker_polygon: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var reflection: CollisionShape2D = $Reflection

var img = [
	preload("res://assets/mirror/mirror_front.tres"), 
	preload("res://assets/mirror/mirror_front_left.tres"),
	preload("res://assets/mirror/mirror_left.tres"),
	preload("res://assets/mirror/mirror_back_left.tres"),
	preload("res://assets/mirror/mirror_back.tres"), 
	preload("res://assets/mirror/mirror_back_right.tres"),
	preload("res://assets/mirror/mirror_right.tres"),
	preload("res://assets/mirror/mirror_front_right.tres"), 
]

var step := 360 / img.size()

func _ready() -> void:
	var index = abs(int(rotation_fake + 22.5) % 360) / step
	sprite.texture = img[index].img
	blocker_polygon.polygon = img[index].polygon
	reflection.rotation = deg_to_rad(rotation_fake)
