extends Container

signal on_clicked_signal(int)
signal on_play_signal(int)

@onready var numbers = [
	preload("res://assets/ui/level_selector_1.png"),
	preload("res://assets/ui/level_selector_2.png"),
	preload("res://assets/ui/level_selector_3.png"),
	preload("res://assets/ui/level_selector_4.png"),
	preload("res://assets/ui/level_selector_5.png"),
	preload("res://assets/ui/level_selector_6.png"),
]

@onready var number: TextureRect = $Number
@onready var play_button: TextureButton = $PlayButton
@onready var star1: TextureRect = $Star1
@onready var star2: TextureRect = $Star2
@onready var star3: TextureRect = $Star3
@onready var mirror: TextureRect = $Mirror

var on_texture: Texture2D = preload("res://assets/ui/level_selector_mirror_on.png")
var off_texture: Texture2D = preload("res://assets/ui/level_selector_mirror_off.png")

var selected: bool = false:
	set(val):
		selected = val
		update_view()

var stars: int = 0:
	set(val):
		stars = val
		update_view()
		
var level_number: int = 1:
	set(val):
		level_number = val
		update_view()
		
func _ready() -> void:
	update_view()

func _process(delta: float) -> void:
	pass

func update_view():
	number.texture = numbers[level_number - 1]
	mirror.texture = off_texture
	number.visible = true
	play_button.visible = false
	star1.visible = false
	star2.visible = false
	star3.visible = false

	if selected:
		mirror.texture = on_texture
		number.visible = false
		play_button.visible = true
		
		if stars >= 1:
			star1.visible = true
		if stars >= 2:
			star2.visible = true
		if stars >= 3:
			star3.visible = true


func _on_general_click_pressed() -> void:
	on_clicked_signal.emit(level_number)


func _on_play_button_pressed() -> void:
	on_play_signal.emit(level_number)
