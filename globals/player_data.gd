extends Node

signal update_placed_mirrors
signal update_timer(val: float)


var levels_data := [
	{"level": 1, "mirrors": 0, "time": 10, "path": "res://scenes/levels/level_1.tscn"},
	{"level": 2, "mirrors": 1, "time": 18, "path": "res://scenes/levels/level_2.tscn"},
	{"level": 3, "mirrors": 1, "time": 18, "path": "res://scenes/levels/level_3.tscn"},
	{"level": 4, "mirrors": 3, "time": 45, "path": "res://scenes/levels/level_4.tscn"},
	{"level": 5, "mirrors": 1, "time": 48, "path": "res://scenes/levels/level_5.tscn"},
	{"level": 6, "mirrors": 2, "time": 70, "path": "res://scenes/levels/level_6.tscn"}
]

var wall_break_shown := false
var current_level := 1

var placed_mirrors: int:
	set(val):
		placed_mirrors = val
		update_placed_mirrors.emit()

var count_time: bool = false
var elapsed_time: float

func _ready() -> void:
	for i in 10:
		levels_data.append(LevelData.new())

func _process(delta: float) -> void:
	#if count_time:
	elapsed_time += delta
	update_timer.emit(elapsed_time)
	
