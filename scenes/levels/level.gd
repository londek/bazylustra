extends Node2D

const MIRROR = preload("res://scenes/objects/mirror.tscn")

@onready var mirrors: Node2D = $Mirrors
@onready var mirror_cursor: MirrorCursor = $MirrorCursor

func _on_mirror_cursor_place_mirror(rotation_deg: float, global_pos: Vector2) -> void:
	var mirror = MIRROR.instantiate()
	mirror.global_position = global_pos
	mirror.rotation_fake = rotation_deg
	mirror.add_to_group("Mirror")
	mirrors.add_child(mirror)
