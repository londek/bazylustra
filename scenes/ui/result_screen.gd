extends CanvasLayer

const STAR = preload("res://assets/ui/result/star.png")

const HOME = preload("res://assets/ui/result/home.png")
const HOME_GLOW = preload("res://assets/ui/result/home_glow.png")
const NEXT = preload("res://assets/ui/result/next.png")
const NEXT_GLOW = preload("res://assets/ui/result/next_glow.png")

@onready var home_btn: Button = $Control/HomeBtn
@onready var next_btn: Button = $Control/NextBtn

func _ready() -> void:
	%TimeLabel.text = get_time_str(PlayerData.elapsed_time) 
	%MirrorLabel.text = str(PlayerData.placed_mirrors)


func get_time_str(time: float) -> String:
	var msec = fmod(time, 1) * 100
	var seconds = fmod(time, 60)
	var minutes = fmod(time, 3600) / 60
	return "%02d:%02d.%03d" % [minutes, seconds, msec]


func _process(delta: float) -> void:
	home_btn.icon = HOME_GLOW if home_btn.is_hovered() else HOME
	next_btn.icon = NEXT_GLOW if next_btn.is_hovered() else NEXT


func _on_home_btn_pressed() -> void:
	SceneTransitions.change_scene_to_path("//home")


func _on_next_btn_pressed() -> void:
	SceneTransitions.change_scene_to_path("//next")
