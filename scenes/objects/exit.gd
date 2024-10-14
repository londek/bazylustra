extends Area2D



func _on_body_entered(body: Node2D) -> void:
	PlayerData.count_time = false
	SceneTransitions.change_scene_to_path("res://scenes/ui/result_screen.tscn")
