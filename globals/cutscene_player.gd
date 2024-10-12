extends CanvasLayer


enum CUTSCENES {WALL_BREAK}


func play(ctscn: CUTSCENES):
	match ctscn:
		CUTSCENES.WALL_BREAK:
			print("smocze jaja")
