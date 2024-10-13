class_name Spike
extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var sprite: Texture
@export var sprite_hid: Texture
@export var enabled: bool = false
@export var flip_horizontal: bool = false


func _ready() -> void:
	switch()
	sprite_2d.flip_h = flip_horizontal	

func _process(delta: float) -> void:
	if !enabled:
		sprite_2d.z_index = -1
	else:
		sprite_2d.z_index = 1

func switch():
	enabled = !enabled
	sprite_2d.texture = sprite if enabled else sprite_hid
	collision_shape_2d.disabled = !enabled
