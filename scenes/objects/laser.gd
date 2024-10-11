class_name Laser

extends Line2D

@export var angle: float = 0

const MAX_BOUNCES = 50

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	var angle_rad = deg_to_rad(angle)
	
	var space_state = get_world_2d().direct_space_state
	var new_points = PackedVector2Array()
	new_points.append(Vector2.ZERO)
	
	var current_angle = Vector2.from_angle(angle_rad)
	var last = null
	for i in range(MAX_BOUNCES):
		var current_point = to_global(new_points[i])
		var ray = current_point+current_angle*10000
		
		var query = PhysicsRayQueryParameters2D.create(current_point, ray)
		if last != null:
			query.exclude = [last]
		
		var result = space_state.intersect_ray(query)
		if result:
			new_points.append(to_local(result.position))
			if result.collider.collision_layer != 2:
				break
			
			last = result.collider
			current_angle = current_angle.bounce(result.normal).normalized()
		else:
			new_points.append(to_local(ray))
			break
	
	points = new_points
