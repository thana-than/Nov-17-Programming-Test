extends Node

@export var input_exit_game := "exit_game"

func _input(event):
	if event.is_action_pressed(input_exit_game):
		get_tree().quit()
