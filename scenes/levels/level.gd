extends Node2D

const MIRROR = preload("res://scenes/objects/mirror.tscn")
@onready var mirrors: Node2D = $Mirrors



func _on_mirror_cursor_place_mirror(rotation_deg: float, global_pos: Vector2, line: SegmentShape2D) -> void:
	var mirror = MIRROR.instantiate()
	mirror.rotation_fake = rotation_deg
	mirror.global_position = global_pos
	mirror.line = line
	mirror.add_to_group("Mirror")
	mirrors.add_child(mirror)
