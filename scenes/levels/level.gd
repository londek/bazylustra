extends Node2D

const MIRROR = preload("res://scenes/objects/mirror.tscn")
@onready var mirrors: Node2D = $Mirrors


func _on_player_place_mirror(rotation_deg: float, global_pos: Vector2) -> void:
	var mirror = MIRROR.instantiate()
	mirrors.add_child(mirror)
	mirror.rotation_degrees = rotation_deg
	mirror.global_position = global_pos
