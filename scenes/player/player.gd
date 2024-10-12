extends CharacterBody2D

const PLAYER_LEFT = preload("res://assets/player/player_left.png")
const PLAYER_DOWN = preload("res://assets/player/player_down.png")
const PLAYER_UP = preload("res://assets/player/player_up.png")


const SPEED = 600.0

var can_move := true
var closest_mirror : Mirror


@export var mirror_cursor: MirrorCursor

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	var mirror_cursor_direction := get_global_mouse_position() - global_position
	var calculated_pos: Vector2 = global_position + mirror_cursor_direction.normalized() * 300
	var mouse_pos: Vector2 = get_global_mouse_position()
	if global_position.distance_to(mouse_pos) < global_position.distance_to(calculated_pos):
		mirror_cursor.global_position = mouse_pos
	else:
		mirror_cursor.global_position = calculated_pos
	#mirror_cursor.global_position = calculated_pos if (calculated_pos.x + calculated_pos.y) / 2 < (mouse_pos.x + mouse_pos.y) / 2 else mouse_pos
	#print(mirror_cursor_direction.normalized())
	#mirror_cursor.global_position = calculated_pos
	
	
	if get_tree().get_node_count_in_group("Mirror"):
		
		var smallest := 10000.0
		for mirr in get_tree().get_nodes_in_group("Mirror"):
			if global_position.distance_to(mirr.global_position) < smallest:
				closest_mirror = mirr
				smallest = global_position.distance_to(mirr.global_position)
		
		for mirr in get_tree().get_nodes_in_group("Mirror"):
			mirr.highlighted = false
		
		closest_mirror.highlighted = true
	
	if Input.is_action_just_pressed("delete") and closest_mirror != null:
		closest_mirror.queue_free()
	
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	
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
