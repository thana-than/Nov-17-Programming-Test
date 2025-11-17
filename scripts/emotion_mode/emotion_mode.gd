extends Node

var mode_weight : float
var mode : bool

@export var mode_change_speed := 2.0

signal on_mode_weight_changed(mode_weight : float)
signal on_mode_changed(mode : bool)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_mode(to_mode: bool):
	if to_mode == self.mode:
		return
	print("SET MODE ", to_mode)
	self.mode = to_mode
	on_mode_changed.emit(self.mode)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var prev_mode_weight = mode_weight
	var target = float(mode)
	mode_weight = move_toward(mode_weight, target, delta * mode_change_speed)
	
	if mode_weight != prev_mode_weight:
		on_mode_weight_changed.emit(mode_weight)
	pass
