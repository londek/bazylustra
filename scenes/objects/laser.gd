class_name Laser

extends Node2D

@export var angle := 0.0

@export var source_color := Color.GREEN
@export var target_color := Color(Color.GREEN, 0.8)

@export var prediction_color := Color(Color.GREEN, 0.15)

@export var source_width := 30
@export var target_width := 20

@export var border_color := Color.BLACK
@export var border_size := 10

@export var mirror_cursor: MirrorCursor

class Line:
	var a: Vector2
	var b: Vector2
	var color: Color
	var width: float
	var border_color: Color
	var border_size: float

var lines: Array[Line] = []

const MAX_DEPTH := 8
const VISUAL_TARGET_DEPTH = 5
const RAY_LENGTH := 10000
const PRISM_ARM_ANGLE := 30

const PLAYER_MASK = pow(2, 1-1)
const REFLECTIVE_MASK = pow(2, 2-1)
const OBSTACLES_MASK = pow(2, 3-1)
const ENTITIES_MASK = pow(2, 4-1)
const MIRROR_ABSORBER_MASK = pow(2, 8-1)
const MIRROR_CURSOR_MASK = pow(2, 9-1)

var previous_colliders: Array[Node] = []
var current_colliders: Array[Node] = []

@onready var mirror_cursor_reflection: Area2D = mirror_cursor.get_node("Reflection") 

func _draw() -> void:
	if lines.size() == 0:
		return
	
	var start = lines[0].a
	
	for line in lines:
		var from = line.a*randf_range(1.00, 1.001)
		var to = line.b*randf_range(1.00, 1.001)
		
		super.draw_line(from, to, line.border_color, line.width+border_size*2*randf_range(1.00, 1.005), true)
		super.draw_line(from, to, line.color, line.width, true)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	lines.clear()
	
	calculate_ray(global_position, Vector2.from_angle(deg_to_rad(angle)))

	for previous_collider in previous_colliders:
		if !is_instance_valid(previous_collider):
			continue
		if previous_collider not in current_colliders:
			if !previous_collider.has_method("_on_laser_exit"):
				continue
			previous_collider._on_laser_exit()

	for current_collider in current_colliders:
		if current_collider not in previous_colliders:
			if !current_collider.has_method("_on_laser_enter"):
				continue
			current_collider._on_laser_enter()

	previous_colliders = current_colliders
	current_colliders = []

	queue_redraw()

func calculate_ray(current_point, current_angle, last=null, is_predicted=false, depth=0):
	if depth > MAX_DEPTH:
		return
		
	var ray = current_point+current_angle*RAY_LENGTH
	var ray_width = lerp(source_width, target_width, float(depth)/float(VISUAL_TARGET_DEPTH))
	var ray_color = lerp(source_color, target_color, float(depth)/float(VISUAL_TARGET_DEPTH))
	var ray_border_color = border_color
	if is_predicted:
		ray_color = prediction_color
		ray_border_color = Color.TRANSPARENT
	
	var space_state = get_world_2d().direct_space_state
	
	var real_query = PhysicsRayQueryParameters2D.create(current_point, ray)
	real_query.collision_mask = PLAYER_MASK + REFLECTIVE_MASK + ENTITIES_MASK + OBSTACLES_MASK + MIRROR_ABSORBER_MASK
	real_query.collide_with_areas = true
	if last != null:
		real_query.exclude = [last]

	var real_result = space_state.intersect_ray(real_query)
	if real_result:
		var current = real_result.collider
		
		if !is_predicted:
			if current.has_method("_on_laser_hit"):
				current._on_laser_hit()

			current_colliders.append(current)
	 
		add_line(to_local(current_point), to_local(real_result.position), ray_color, ray_width, ray_border_color, border_size)

		if current is Prism:
			calculate_ray(real_result.position, current_angle.rotated(deg_to_rad(PRISM_ARM_ANGLE)), current, is_predicted, depth+1)
			calculate_ray(real_result.position, current_angle.rotated(deg_to_rad(-PRISM_ARM_ANGLE)), current, is_predicted, depth+1)
		elif current.collision_layer == pow(2, 2-1):
			calculate_ray(real_result.position, current_angle.bounce(real_result.normal), current, is_predicted, depth+1)

	# Check for MirrorCursor if we are not traversing predicted node
	if is_predicted:
		return
	
	var fake_query = PhysicsRayQueryParameters2D.create(current_point, ray)
	fake_query.collision_mask = PLAYER_MASK + REFLECTIVE_MASK + ENTITIES_MASK + OBSTACLES_MASK + MIRROR_CURSOR_MASK
	fake_query.collide_with_areas = true
	if last != null:
		fake_query.exclude = [last]

	var fake_result = space_state.intersect_ray(fake_query)
	if fake_result:
		var current = fake_result.collider
		
		if current == mirror_cursor_reflection:
			if !mirror_cursor.is_placeable():
				return
			
			add_line(to_local(current_point), to_local(fake_result.position), ray_color, ray_width, ray_border_color, border_size)
			calculate_ray(fake_result.position, current_angle.bounce(fake_result.normal), current, true, depth+1)

func add_line(a: Vector2, b: Vector2, color: Color, width: float, border_color=Color.TRANSPARENT, border_size=0) -> void:
	var line = Line.new()
	line.a = a
	line.b = b
	line.color = color
	line.width = width
	line.border_color = border_color
	line.border_size = border_size

	lines.append(line)
