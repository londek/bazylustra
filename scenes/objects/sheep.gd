class_name Sheep

extends StaticBody2D

@export var mainTexture: Texture2D
@export var stonedTexture: Texture2D 

var isStoned := false

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass

func _on_hit_with_laser():
	if isStoned:
		return
		
	$"Sprite2D".texture = stonedTexture
	
	collision_layer = 0
	
