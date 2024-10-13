extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var start_btn: Button = $StartBtn

const START_BTN_OFF = preload("res://assets/ui/start_btn_off.png")
const START_BTN_ON = preload("res://assets/ui/start_btn_on.png")

signal start_btn_appear

const WALL_BREAK: Dictionary = {
		"img_array": [preload("res://assets/cutscenes/wall_break_1.png"), preload("res://assets/cutscenes/wall_break_2.png"), preload("res://assets/cutscenes/wall_break_3.png"), preload("res://assets/cutscenes/wall_break_4.png"), preload("res://assets/cutscenes/wall_break_5.png")],
		"delay": 1.0
	}
const MAIN_MENU := {
	"img_array": [preload("res://assets/ui/main_menu_closed.png"), preload("res://assets/ui/main_menu_open_1.png"), preload("res://assets/ui/main_menu_open_2.png"), preload("res://assets/ui/main_menu_open_3.png"), preload("res://assets/ui/main_menu_open_4.png"), preload("res://assets/ui/main_menu_open_5.png")]
}
const GAME_START := {
	"img": preload("res://assets/ui/game_start.png"),
	"scene": "res://scenes/levels/level.tscn"
}

func _ready() -> void:
	start_btn.hide()


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
			#Shaker.shake(sprite_2d, 35, 1)
			#sprite_2d.texture = WALL_BREAK["img_array"][3] 
			#await get_tree().create_timer(1).timeout
			Shaker.shake(sprite_2d, 50, 0.7)
			sprite_2d.texture = WALL_BREAK["img_array"][4]
			await get_tree().create_timer(1.5).timeout
			animation_player.play("FadeToBlack")
			await animation_player.animation_finished
			sprite_2d.texture = null
			animation_player.play_backwards("FadeToBlack")
		MAIN_MENU:
			await animation_player.animation_finished
			animation_player.play_backwards("FadeToBlack")
			sprite_2d.texture = MAIN_MENU["img_array"][0]
			await animation_player.animation_finished
			await get_tree().create_timer(1).timeout
			sprite_2d.texture = MAIN_MENU["img_array"][1]
			Shaker.shake(sprite_2d, 10, 0.2) 
			await get_tree().create_timer(1).timeout
			sprite_2d.texture = MAIN_MENU["img_array"][2]
			Shaker.shake(sprite_2d, 10, 0.2)
			await get_tree().create_timer(1).timeout
			sprite_2d.texture = MAIN_MENU["img_array"][3]
			Shaker.shake(sprite_2d, 10, 0.2)
			await get_tree().create_timer(1).timeout
			sprite_2d.texture = MAIN_MENU["img_array"][4]
			Shaker.shake(sprite_2d, 10, 0.2)
			await get_tree().create_timer(1.5).timeout
			Shaker.shake(sprite_2d, 50, 1.5)
			await get_tree().create_timer(1.5).timeout 
			sprite_2d.texture = MAIN_MENU["img_array"][5]
			
			start_btn.show()
			var tween := get_tree().create_tween()
			tween.tween_property(start_btn, "modulate:a", 0.5, 1)
		GAME_START:
			await animation_player.animation_finished
			#animation_player.play_backwards("FadeToBlack")
			sprite_2d.texture = GAME_START["img"]
			await get_tree().create_timer(2).timeout 
			SceneTransitions.change_scene_to_path(GAME_START["scene"])
			sprite_2d.hide()

	#visible = false
			#animation_player.play("FadeToBlack")
			#await animation_player.animation_finished
			#sprite_2d.texture = null
			#animation_player.play_backwards("FadeToBlack")
			


func _on_start_btn_pressed() -> void:
	start_btn.hide()
	 
	play(GAME_START)

func _process(delta: float) -> void:
	start_btn.icon = START_BTN_ON if start_btn.is_hovered() else START_BTN_OFF
