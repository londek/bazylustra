extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var latest_target: String


func change_scene_to_path(target: String) -> void:
	animation_player.play("FadeToBlack")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("FadeToBlack")


func change_scene_to_packed(target: PackedScene) -> void:
	animation_player.play("FadeToBlack")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(target)
	animation_player.play_backwards("FadeToBlack")


func reload_scene_persona():
	animation_player.play("PersonaFlash")


func reload_scene_eye() -> void:
	animation_player.play("FadeToBlack")
	await animation_player.animation_finished
	animation_player.play_backwards("FadeToBlack")


func reload_scene() -> void:
	get_tree().reload_current_scene()
