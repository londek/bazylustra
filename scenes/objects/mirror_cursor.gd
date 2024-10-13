class_name MirrorCursor
extends Node2D

signal place_mirror(rotation_deg: float, global_pos: Vector2)
var rotation_speed := 150
var rotation_little_speed := 300

@onready var sprite_2d: Sprite2D = $Sprite2D


func _process(delta: float) -> void:
	if !is_placeable():
		sprite_2d.material.set("shader_parameter/Blend", 0.5)
		sprite_2d.material.set("shader_parameter/Alpha", 0.7)
	else:
		sprite_2d.material.set("shader_parameter/Blend", 1.0)
		sprite_2d.material.set("shader_parameter/Alpha", 0.8)
	
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rotation_speed * delta
		if rotation_degrees < 0:
			rotation_degrees = 360 + rotation_degrees
	
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rotation_speed * delta
		if rotation_degrees > 360:
			rotation_degrees = rotation_degrees - 360
	
	if Input.is_action_just_pressed("rotate_left_little"):
		rotation_degrees -= rotation_little_speed * delta
		if rotation_degrees < 0:
			rotation_degrees = 360 + rotation_degrees
	
	if Input.is_action_just_pressed("rotate_right_little"):
		rotation_degrees += rotation_little_speed * delta
		if rotation_degrees > 360:
			rotation_degrees = rotation_degrees - 360
	
	if Input.is_action_just_pressed("place"):
		if !is_placeable():
			return
			
		place_mirror.emit(rotation_degrees, global_position)

func is_placeable():
	if $ObstructionArea.has_overlapping_areas():
		return false
	if $ObstructionArea.has_overlapping_bodies():
		return false
		
	return true
