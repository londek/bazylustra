extends CanvasLayer

const STAR = preload("res://assets/ui/result/star.png")
const HEART = preload("res://scenes/ui/heart.tscn")

const HOME = preload("res://assets/ui/result/home.png")
const HOME_GLOW = preload("res://assets/ui/result/home_glow.png")
const NEXT = preload("res://assets/ui/result/next.png")
const NEXT_GLOW = preload("res://assets/ui/result/next_glow.png")

@onready var home_btn: Button = $Control/HomeBtn
@onready var next_btn: Button = $Control/NextBtn

var stars := 1
var seconds := 0.0
var minutes := 0.0


func _ready() -> void:
	await SceneTransitions.animation_player.animation_finished
	SceneTransitions.layer = 0
	CutscenePlayer.layer = 0
	layer = 1
	PlayerData.current_level += 1
	if PlayerData.levels_data[PlayerData.current_level-1]["mirrors"] >= PlayerData.placed_mirrors: 
		stars += 1
	if PlayerData.levels_data[PlayerData.current_level-1]["time"] >= minutes * 60 + seconds:
		stars += 1
	await get_tree().create_timer(0.5).timeout
	%MirrorLabel.text = str(PlayerData.placed_mirrors)
	await get_tree().create_timer(0.5).timeout
	%TimeLabel.text = get_time_str(PlayerData.elapsed_time) 
	for star in stars:
		if get_tree():
			await get_tree().create_timer(0.5).timeout
			%Hearts.add_child(HEART.instantiate())


func get_time_str(time: float) -> String:
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	return "%02d:%02d" % [minutes, seconds]


func _process(delta: float) -> void:
	home_btn.icon = HOME_GLOW if home_btn.is_hovered() else HOME
	next_btn.icon = NEXT_GLOW if next_btn.is_hovered() else NEXT


func _on_home_btn_pressed() -> void:
	SceneTransitions.change_scene_to_path("res://scenes/ui/level_selector/level_selector.tscn")


func _on_next_btn_pressed() -> void:
	if PlayerData.current_level <= 6:
		SceneTransitions.change_scene_to_path(PlayerData.levels_data[PlayerData.current_level-1]["path"])
	else:
		CutscenePlayer.play(CutscenePlayer.GAME_END)
