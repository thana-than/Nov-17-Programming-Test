extends Node
class_name EmotionModeController

func set_mode(mode):
	EmotionMode.set_mode(mode)

func set_mode_off():
	set_mode(false)

func set_mode_on():
	set_mode(true)
