extends Node2D

const OFFSET := 630

@onready var levels_container: Container = $CanvasLayer/Container

@onready var mirrors = [
	$CanvasLayer/Container/MirrorLvl1,
	$CanvasLayer/Container/MirrorLvl2,
	$CanvasLayer/Container/MirrorLvl3,
	$CanvasLayer/Container/MirrorLvl4,
	$CanvasLayer/Container/MirrorLvl5,
	$CanvasLayer/Container/MirrorLvl6,
]

var current_tween: Tween = null

var selected: int = 1:
	set(val):
		mirrors[selected-1].selected = false
		selected = val
		mirrors[selected-1].selected = true

func on_mirror_clicked(level_number: int):
	selected = level_number

func on_play(level_number: int):
	print("wanna play")
	print(level_number)
	
	#SceneTransitions.change_scene_to_path("")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(mirrors.size()):
		mirrors[i].level_number = i + 1
		mirrors[i].on_clicked_signal.connect(on_mirror_clicked)
		mirrors[i].on_play_signal.connect(on_play)
		
	selected = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_left():
	if current_tween != null:
		if current_tween.is_running():
			return
	
	current_tween = create_tween()
	current_tween.tween_property(levels_container, "global_position", levels_container.global_position + Vector2.LEFT * OFFSET, 0.7).set_trans(Tween.TRANS_CUBIC)
	
func move_right():
	if current_tween != null:
		if current_tween.is_running():
			return
			
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.tween_property(levels_container, "global_position", levels_container.global_position - Vector2.LEFT * OFFSET, 0.7).set_trans(Tween.TRANS_CUBIC)


func _on_left_button_pressed() -> void:
	move_left()


func _on_right_button_pressed() -> void:
	move_right()
