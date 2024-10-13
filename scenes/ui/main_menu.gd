extends CanvasLayer

@onready var start_btn: Button = $StartBtn

func _ready() -> void:
	CutscenePlayer.connect("start_btn_appear", _on_start_btn_appear)


func _on_start_btn_appear():
	var tween := get_tree().create_tween()
	tween.tween_property(start_btn, "modulate:a", 0.8, 3)
	#tween.tween_callback(func(): start_btn.disabled = false)


func _on_start_btn_pressed() -> void:
	print("jajaja")
