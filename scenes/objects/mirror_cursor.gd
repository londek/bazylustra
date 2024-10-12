class_name MirrorCursor
extends Node2D

signal place_mirror(rotation_deg: float, global_pos: Vector2, line: SegmentShape2D)
var rotation_speed := 150
var rotation_little_speed := 300

@onready var reflection: CollisionShape2D = $Reflection

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#global_position = get_global_mouse_position()
	
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
		print(reflection.shape)
		place_mirror.emit(rotation_degrees, global_position, reflection.shape)
