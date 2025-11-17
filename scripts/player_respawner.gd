extends Node
class_name PlayerRespawner

@onready var player : PlayerCharacterBody2D = get_parent()
@export var input_respawn := "respawn"

var startPosition : Vector2 

func _ready() -> void:
	startPosition = player.position
	player.on_hit.connect(respawn)

func respawn():
	player.position = startPosition
	player.velocity = Vector2.ZERO
	
func _unhandled_input(event):
	if event.is_action_pressed(input_respawn):
		respawn()
