class_name Mirror
extends StaticBody2D

const MIRROR_HIGHLIGHT = preload("res://scenes/objects/mirror_highlight.gdshader")

@onready var light: PointLight2D = $PointLight2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var blocker_polygon: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var reflection: CollisionShape2D = $Reflection

@export var rotation_fake := 0
@export var arr: PackedVector2Array
@export var line: SegmentShape2D
@export var highlighted: bool = false:
	set(val):
		highlighted = val
		light.enabled = highlighted
		if highlighted:
			sprite.material.set("shader", MIRROR_HIGHLIGHT)
		else:
			sprite.material.set("shader", null)
			


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
	reflection.shape = line
	reflection.rotation_degrees = rotation_fake
	var index = abs(int(rotation_fake + 22.5) % 360) / step
	sprite.texture = img[index].img
	blocker_polygon.polygon = img[index].polygon
	print("IMG: " + str(img[index].img) + " | Polygon: " + str(img[index].polygon))
