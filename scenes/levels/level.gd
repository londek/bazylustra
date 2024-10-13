extends Node2D

const MIRROR = preload("res://scenes/objects/mirror.tscn")

@onready var mirrors: Node2D = $Mirrors

@export var level_data: LevelData
@export var in_game_ui: CanvasLayer


func _ready() -> void:
	PlayerData.placed_mirrors = 0
	PlayerData.count_time = true


func _stop() -> void:
	set_process(false)


func _on_mirror_cursor_place_mirror(rotation_deg: float, global_pos: Vector2) -> void:
	var mirror = MIRROR.instantiate()
	mirror.global_position = global_pos
	mirror.rotation_fake = rotation_deg
	mirror.add_to_group("Mirror")
	mirrors.add_child(mirror)
