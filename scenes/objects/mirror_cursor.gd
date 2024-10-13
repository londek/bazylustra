class_name MirrorCursor
extends Node2D


signal place_mirror(rotation_deg: float, global_pos: Vector2)
var rotation_speed := 150
var rotation_little_speed := 300

func _ready() -> void:
	pass

func _process(delta: float) -> void:
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
