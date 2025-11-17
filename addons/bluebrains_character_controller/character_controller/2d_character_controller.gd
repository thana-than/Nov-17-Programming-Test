extends CharacterBody2D
class_name PlayerCharacterBody2D

signal on_hit()
#@onready var ledge_detector_r: LedgeDetector = %LedgeDetectorR
#@onready var ledge_detector_l: LedgeDetector = %LedgeDetectorL
@onready var state_machine: CharacterControllerStateMachine = %StateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

@export var character_size: Vector2

@export_group("Control Variables")
@export var looking_left := false

func hit(_source : Node):
	on_hit.emit()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	animated_sprite_2d.flip_h = looking_left
