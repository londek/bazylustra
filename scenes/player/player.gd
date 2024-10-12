extends CharacterBody2D

const PLAYER_LEFT = preload("res://assets/player/player_left.png")
const PLAYER_DOWN = preload("res://assets/player/player_down.png")
const PLAYER_UP = preload("res://assets/player/player_up.png")

const SPEED = 600.0
const MIN_MIRROR_RANGE = 400.0
const MAX_MIRROR_RANGE = 700.0

var can_move := true
var closest_mirror : Mirror

@export var mirror_cursor: MirrorCursor

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _draw() -> void:
	draw_circle(Vector2.ZERO, MAX_MIRROR_RANGE, Color(Color.WHITE, 0.05), false, 5)

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	var mouse_local_position := get_local_mouse_position()
	
	if mouse_local_position.length() > MAX_MIRROR_RANGE:
		mirror_cursor.global_position = global_position + mouse_local_position.normalized() * MAX_MIRROR_RANGE
	elif mouse_local_position.length() < MIN_MIRROR_RANGE:
		mirror_cursor.global_position = global_position + mouse_local_position.normalized() * MIN_MIRROR_RANGE
	else:
		mirror_cursor.global_position = global_position + mouse_local_position
	
	
	if get_tree().get_node_count_in_group("Mirror"):
		
		var smallest := 10000.0
		for mirr in get_tree().get_nodes_in_group("Mirror"):
			if get_global_mouse_position().distance_to(mirr.global_position) < smallest:
				closest_mirror = mirr
				smallest = global_position.distance_to(mirr.global_position)
		
		for mirr in get_tree().get_nodes_in_group("Mirror"):
			mirr.highlighted = false
		
		closest_mirror.highlighted = true
	
	if Input.is_action_just_pressed("delete") and closest_mirror != null:
		closest_mirror.queue_free()
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * SPEED
	
	if !velocity:
		animation_player.play("idle_down")
	
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
