class_name Laser

extends Node2D

@export var angle: float = 0
@export var source_color: Color = Color.WHITE
@export var target_color: Color = Color(230, 230, 230, 0.4)
@export var source_width: float = 10
@export var target_width: float = 6

class Line:
	var a: Vector2
	var b: Vector2
	var color: Color
	var width: float

var lines: Array[Line] = []

const MAX_DEPTH := 80
const VISUAL_TARGET_DEPTH = 5
const RAY_LENGTH := 10000
const PRISM_ARM_ANGLE := 30

var previous_colliders: Array[Node] = []
var current_colliders: Array[Node] = []

func _draw() -> void:
	for line in lines:
		super.draw_line(line.a, line.b, line.color, line.width, true)

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	lines.clear()
	draw_ray(to_global(Vector2.ZERO), Vector2.from_angle(deg_to_rad(angle)))

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

func draw_ray(current_point, current_angle, last=null, depth=0):
	if depth > MAX_DEPTH:
		return

	var ray_color = lerp(source_color, target_color, float(depth)/float(VISUAL_TARGET_DEPTH))
	var ray_width = lerp(source_width, target_width, float(depth)/float(VISUAL_TARGET_DEPTH))
	var ray = current_point+current_angle*RAY_LENGTH

	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(current_point, ray)
	query.collision_mask = 0xffffffff - pow(2, 6-1)
	query.collide_with_areas = true
	if last != null:
		query.exclude = [last]

	var result = space_state.intersect_ray(query)
	if !result:
		draw_line2(to_local(current_point), to_local(ray), ray_color, ray_width)
		return

	if result.collider.collision_layer == 6:
		return

	if result.collider.has_method("_on_laser_hit"):
		result.collider._on_laser_hit()

	current_colliders.append(result.collider)
	last = result.collider

	draw_line2(to_local(current_point), to_local(result.position), ray_color, ray_width)

	if result.collider is Prism:
		draw_ray(result.position, current_angle.rotated(deg_to_rad(PRISM_ARM_ANGLE)), last, depth+1)
		draw_ray(result.position, current_angle.rotated(deg_to_rad(-PRISM_ARM_ANGLE)), last, depth+1)
		return

	if result.collider.collision_layer != 2:
		return

	current_angle = current_angle.bounce(result.normal)

	draw_ray(result.position, current_angle, last, depth+1)

func draw_line2(a: Vector2, b: Vector2, color: Color, width: float) -> void:
	var line = Line.new()
	line.a = a
	line.b = b
	line.color = color
	line.width = width

	lines.append(line)
