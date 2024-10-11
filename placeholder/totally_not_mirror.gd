extends StaticBody2D

var rotation_speed := 200

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
	
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
