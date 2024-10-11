extends CharacterBody2D

const PLAYER_LEFT = preload("res://assets/player/player_left.png")
const PLAYER_DOWN = preload("res://assets/player/player_down.png")
const PLAYER_UP = preload("res://assets/player/player_up.png")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var rotation_speed := 200

@export var mirror: Mirror


func _physics_process(delta: float) -> void:
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	mirror.global_position = get_global_mouse_position()
	
	if Input.is_action_pressed("rotate_left"):
		mirror.rotation_degrees -= rotation_speed * delta
	
	if Input.is_action_pressed("rotate_right"):
		mirror.rotation_degrees += rotation_speed * delta
	
	velocity = direction * SPEED
	
	if velocity:
		$Sprite2D.flip_h = velocity.x > 0
	
	if velocity.y:
		$Sprite2D.texture = PLAYER_DOWN if velocity.y > 0 else PLAYER_UP
	else:
		if velocity.x:
			$Sprite2D.texture = PLAYER_LEFT

	move_and_slide()
