extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var texture_rect: TextureRect = $TextureRect
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum CUTSCENES {WALL_BREAK}

const WALL_BREAK: Dictionary = {
		"img_array": [preload("res://assets/cutscenes/wall_break_1.png"), preload("res://assets/cutscenes/wall_break_2.png"), preload("res://assets/cutscenes/wall_break_3.png"), preload("res://assets/cutscenes/wall_break_4.png"), preload("res://assets/cutscenes/wall_break_5.png")],
		"delay": 1.0
	}


func play(ctscn: Dictionary):
	animation_player.play("FadeToBlack")
	match ctscn:
		WALL_BREAK:
			await animation_player.animation_finished
			animation_player.play_backwards("FadeToBlack")
			sprite_2d.texture = WALL_BREAK["img_array"][0]
			await animation_player.animation_finished
			Shaker.shake(sprite_2d, 15, 1)
			sprite_2d.texture = WALL_BREAK["img_array"][1]
			await get_tree().create_timer(1).timeout
			Shaker.shake(sprite_2d, 20, 1)
			sprite_2d.texture = WALL_BREAK["img_array"][2]
			await get_tree().create_timer(1).timeout
			Shaker.shake(sprite_2d, 35, 1)
			sprite_2d.texture = WALL_BREAK["img_array"][3] 
			await get_tree().create_timer(1).timeout
			Shaker.shake(sprite_2d, 50, 0.7)
			sprite_2d.texture = WALL_BREAK["img_array"][4]
			await get_tree().create_timer(1.5).timeout
			animation_player.play("FadeToBlack")
			await animation_player.animation_finished
			sprite_2d.texture = null
			animation_player.play_backwards("FadeToBlack")
			
