extends Node

var levels_data: Array[LevelData]

signal update_placed_mirrors
signal update_timer(val: float)

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
	
