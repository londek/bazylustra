extends CharacterBody2D

const PLAYER_LEFT = preload("res://assets/player/player_left.png")
const PLAYER_DOWN = preload("res://assets/player/player_down.png")
const PLAYER_UP = preload("res://assets/player/player_up.png")

signal place_mirror(rotation_deg: float, global_pos: Vector2)

const SPEED = 600.0

var rotation_speed := 200
var can_move := true

@export var mirror_cursor: Mirror

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	mirror_cursor.global_position = get_global_mouse_position()
	
	for mirr in get_tree().get_nodes_in_group("Mirror"):
		if mirr.global_position == get_global_mouse_position():
			continue
		
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	
	if Input.is_action_pressed("rotate_left"):
		mirror_cursor.rotation_fake -= rotation_speed * delta
	
	if Input.is_action_pressed("rotate_right"):
		mirror_cursor.rotation_fake += rotation_speed * delta
	
	if Input.is_action_just_pressed("place"):
		place_mirror.emit(mirror_cursor.rotation_fake, mirror_cursor.global_position)
	
	velocity = direction * SPEED
	
	if velocity.x:
		$Sprite2D.flip_h = velocity.x > 0
	
	if velocity.y:
		if velocity.y > 0:
			animation_player.play("walk_down")
		else:
			animation_player.play("walk_up")
	else:
		if velocity.x:
			animation_player.play("walk_left")


	move_and_slide()
