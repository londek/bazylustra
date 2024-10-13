extends CharacterBody2D

const PLAYER_LEFT = preload("res://assets/player/player_left.png")
const PLAYER_DOWN = preload("res://assets/player/player_down.png")
const PLAYER_UP = preload("res://assets/player/player_up.png")

@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 800.0
const MIN_MIRROR_RANGE = 400.0
const MAX_MIRROR_RANGE = 800.0
const MAX_SELECT_RANGE = 800.0

var closest_mirror : Mirror
var is_stoned:
	set(val):
		is_stoned = val
		var tween := get_tree().create_tween().set_trans(Tween.TRANS_SINE)
		if is_stoned:
			SceneTransitions.reload_scene_persona()
			tween.tween_method(update_shader_val, 0.0, 1.0, 0.5)
			animation_player.pause()
		else:
			tween.tween_method(update_shader_val, 1.0, 0.0, 0.5)

var conscutive_hits := 0

@export var mirror_cursor: MirrorCursor

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	is_stoned = false

func _draw() -> void:
	draw_circle(Vector2.ZERO, MAX_MIRROR_RANGE, Color(Color.WHITE, 0.05), false, 5)

func _physics_process(delta: float) -> void:
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
				smallest = get_global_mouse_position().distance_to(mirr.global_position)
		
		for mirr in get_tree().get_nodes_in_group("Mirror"):
			mirr.highlighted = false
		
		if global_position.distance_to(closest_mirror.global_position) > MAX_SELECT_RANGE:
			closest_mirror = null
			
	if closest_mirror != null:
		closest_mirror.highlighted = true
		
		if Input.is_action_just_pressed("delete"):
			closest_mirror.queue_free()
		
	if Input.is_action_just_pressed("reset"):
		SceneTransitions.reload_scene_eye()
	
	if Input.is_action_just_pressed("shake"):
		#SmartCamera.shake(0.5, 30, 20) 
		CutscenePlayer.play(CutscenePlayer.WALL_BREAK)
	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if is_stoned:
		return
	
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

func update_shader_val(val: float):
	sprite_2d.material.set("shader_parameter/progress", val)

func _on_laser_enter():
	conscutive_hits = 0
	
func _on_laser_exit():
	is_stoned = false

func _on_laser_hit():
	conscutive_hits += 1
	if conscutive_hits > 4:
		is_stoned = true
