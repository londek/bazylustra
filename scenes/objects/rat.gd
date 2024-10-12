class_name Rat

extends CharacterBody2D

@export var main_texture: Texture2D
@export var stoned_texture: Texture2D 

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
			
	move_and_slide()

func _on_laser_enter():
	$Sprite2D.texture = stoned_texture
	is_stoned = true
	
func _on_laser_exit():
	$Sprite2D.texture = main_texture
	is_stoned = false
