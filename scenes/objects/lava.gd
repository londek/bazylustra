@tool
extends StaticBody2D

const LAVA_TOP = preload("res://assets/objects/lava_top.png")
const LAVA_MIDDLE = preload("res://assets/objects/lava_middle.png")
const LAVA_BOTTOM = preload("res://assets/objects/lava_bottom.png")

const LAVA_TILE_BOTTOM = preload("res://scenes/objects/lava_tile_bottom.tscn")
const LAVA_TILE_MIDDLE = preload("res://scenes/objects/lava_tile_middle.tscn")
const LAVA_TILE_TOP = preload("res://scenes/objects/lava_tile_top.tscn")

@export var size: int


func _ready() -> void:
	for i in range(0, size):
		if i == 0:
			var tile = LAVA_TILE_TOP.instantiate()
			add_child(tile)
		elif i == size-2:
			var tile = LAVA_TILE_BOTTOM.instantiate()
			add_child(tile)
			tile.position.y = i * 183  +  100
		else:
			var tile = LAVA_TILE_MIDDLE.instantiate()
			add_child(tile)
			tile.position.y = i * 183
