class_name Mirror
extends Node2D

const MIRROR_HIGHLIGHT = preload("res://scenes/objects/mirror_highlight.gdshader")

@onready var light: PointLight2D = $PointLight2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var surface: Node2D = $Surface

@export var rotation_fake := 0
@export var arr: PackedVector2Array
@export var line: SegmentShape2D
@export var highlighted: bool = false:
	set(val):
		if immovable:
			return
		highlighted = val
		light.enabled = highlighted
		if highlighted:
			sprite.material.set("shader", MIRROR_HIGHLIGHT)
		else:
			sprite.material.set("shader", null)
@export var immovable: bool = false


var mirror_res = [
	preload("res://assets/mirror/mirror_front.tres"), 
	preload("res://assets/mirror/mirror_front_left.tres"),
	preload("res://assets/mirror/mirror_left.tres"),
	preload("res://assets/mirror/mirror_back_left.tres"),
	preload("res://assets/mirror/mirror_back.tres"), 
	preload("res://assets/mirror/mirror_back_right.tres"),
	preload("res://assets/mirror/mirror_right.tres"),
	preload("res://assets/mirror/mirror_front_right.tres"), 
]

var reflects_front = [
	true,
	true,
	true,
	false,
	false,
	false,
	false,
	true,
]

var step := 360 / mirror_res.size()

func _ready() -> void:
	if immovable:
		sprite.material.set("shader_parameter/color", Color.FIREBRICK)
	
	if line != null:
		surface.rotation_degrees = rotation_fake
	
	var index = abs(int(rotation_fake + 22.5) % 360) / step

	sprite.texture = mirror_res[index].img
	print(reflects_front[index])
	if reflects_front[index]:
		z_index = -1
