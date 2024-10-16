class_name Bat
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var walkable_area: Area2D = $WalkableArea
@onready var walkable_collision: CollisionShape2D = $WalkableArea/CollisionShape2D

@export var waypoint_a: Vector2
@export var waypoint_b: Vector2

@export var speed: float = 100

const BAT_FLY_UP_4 = preload("res://assets/bat/bat_fly_up_4.png")
const BAT_FLY_DOWN_1 = preload("res://assets/bat/bat_fly_down_1.png")

const DISTANCE_THRESHOLD := 2

var is_stoned:
	set(val):
		is_stoned = val
		walkable_collision.disabled = !is_stoned
		var tween := get_tree().create_tween().set_trans(Tween.TRANS_SINE)
		if is_stoned:
			sprite_2d.texture = BAT_FLY_DOWN_1 if velocity.y > 0 else BAT_FLY_UP_4
			tween.tween_method(update_shader_val, 0.0, 0.9, 0.5)
			animation_player.pause()
			$AudioStreamPlayer2D.play()
		else:
			tween.tween_method(update_shader_val, 0.9, 0.0, 0.5)


var direction_flag := false

func _ready() -> void:
	global_position = waypoint_a
	is_stoned = false

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

func update_shader_val(val: float):
	sprite_2d.material.set("shader_parameter/progress", val)


func _on_laser_enter():
	is_stoned = true


func _on_laser_exit():
	is_stoned = false
	pass


func _on_walkable_area_body_entered(body: Node2D) -> void:
	body.set_collision_mask_value(6, false)


func _on_walkable_area_body_exited(body: Node2D) -> void:
	body.set_collision_mask_value(6, true)
