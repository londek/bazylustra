extends CanvasLayer


var minutes := 0
var seconds := 0
var msec := 0

func _ready() -> void:
	PlayerData.connect("update_placed_mirrors", func(): %MirrorsLabel.text = str(PlayerData.placed_mirrors) + "x ")
	PlayerData.connect("update_timer", func(val: float): _update_timer(val))


func _update_timer(time: float):
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	%Minutes.text = "%02d:" % minutes
	%Seconds.text = "%02d." % seconds
	%Msecs.text = "%03d" % msec
