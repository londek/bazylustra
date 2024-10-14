extends Node2D

const MIRROR = preload("res://scenes/objects/mirror.tscn")

@onready var mirrors: Node2D = $Mirrors

@export var this_level: int

func _ready() -> void:
	PlayerData.current_level = this_level
	PlayerData.elapsed_time = 0
	PlayerData.placed_mirrors = 0
	PlayerData.count_time = true
	
	if this_level == 1 and !PlayerData.wall_break_shown:
		$Laser.hide()
		await get_tree().create_timer(3).timeout
		CutscenePlayer.play(CutscenePlayer.WALL_BREAK)
		await get_tree().create_timer(2).timeout
		$Laser.show()
		PlayerData.wall_break_shown = true

func _stop() -> void:
	set_process(false)


func _on_mirror_cursor_place_mirror(rotation_deg: float, global_pos: Vector2) -> void:
	var mirror = MIRROR.instantiate()
	mirror.global_position = global_pos
	mirror.rotation_fake = rotation_deg
	mirror.add_to_group("Mirror")
	mirrors.add_child(mirror)
