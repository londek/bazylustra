class_name Laser

extends Node2D

@export var angle: float = 0

@export var color: Color = Color.WHITE
@export var width: float = 1 

class Line:
	var a: Vector2
	var b: Vector2

var lines: Array[Line] = []

const MAX_DEPTH := 10
const RAY_LENGTH := 10000
const PRISM_ARM_ANGLE := 30

func _draw() -> void:
	for line in lines:
		super.draw_line(line.a, line.b, color, width, true)

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	#var new_points := PackedVector2Array()
	#new_points.append(Vector2.ZERO)
	#points.clear()
	#clear_points()
	#add_point(Vector2.ZERO)
	lines.clear()
	draw_ray(to_global(Vector2.ZERO), Vector2.from_angle(deg_to_rad(angle)))
	queue_redraw()
	#print(points.size())
	#points = new_points

func draw_ray(current_point, current_angle, last=null, depth=0):
	if depth > MAX_DEPTH:
		return
	
	var ray = current_point+current_angle*RAY_LENGTH
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(current_point, ray)
	if last != null:
		query.exclude = [last]
	
	var result = space_state.intersect_ray(query)
	if !result:
		draw_line2(to_local(current_point), to_local(ray))
		return
	
	if result.collider.has_method("_on_hit_with_laser"):
		result.collider._on_hit_with_laser()
	
	last = result.collider
	
	draw_line2(to_local(current_point), to_local(result.position))
	
	if result.collider is Prism:
		draw_ray(result.position, current_angle.rotated(deg_to_rad(PRISM_ARM_ANGLE)), last, depth+1)
		draw_ray(result.position, current_angle.rotated(deg_to_rad(-PRISM_ARM_ANGLE)), last, depth+1)
		return
		
	if result.collider.collision_layer != 2:
		return
	
	current_angle = current_angle.bounce(result.normal)
		
	draw_ray(result.position, current_angle, last, depth+1)

func draw_line2(a: Vector2, b: Vector2) -> void:
	var line = Line.new()
	line.a = a
	line.b = b
	
	lines.append(line)
