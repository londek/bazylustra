class_name Bat
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var waypoint_a: Vector2
@export var waypoint_b: Vector2

@export var speed: float = 100

const DISTANCE_THRESHOLD := 2

var is_stoned := false
var direction_flag := false

func _ready() -> void:
	global_position = waypoint_a

func _physics_process(delta: float) -> void:
	if is_stoned:
		return
	
	if direction_flag:
		velocity = global_position.direction_to(waypoint_b) * speed
		if global_position.distance_to(waypoint_b) < DISTANCE_THRESHOLD:
			direction_flag = false
	else:
		velocity = global_position.direction_to(waypoint_a) * speed
		if global_position.distance_to(waypoint_a) < DISTANCE_THRESHOLD:
			direction_flag = true
	
	
	if velocity.x:
		$Sprite2D.flip_h = velocity.x > 0
	
	if velocity.y:
		if velocity.y > 0:
			animation_player.play("fly_down")
		else:
			animation_player.play("fly_up")
	else:
		if velocity.x:
			animation_player.play("fly_left")
	
	
	move_and_slide()

func _on_laser_enter():
	is_stoned = true
	
func _on_laser_exit():
	is_stoned = false
