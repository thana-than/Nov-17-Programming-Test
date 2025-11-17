extends Node
class_name EmotionModeListener

@export var weight_curve : CurveTexture

var mode_weight : float:
	get:
		return _sample(EmotionMode.mode_weight)
		
var mode : bool:
	get:
		return EmotionMode.mode

signal on_mode_weight_changed(mode_weight : float)
signal on_mode_changed(mode : bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EmotionMode.on_mode_weight_changed.connect(_emit_sampled_weight)
	EmotionMode.on_mode_changed.connect(on_mode_changed.emit)
	
func _sample(raw_weight: float) -> float:
	var val = raw_weight
	if weight_curve:
		val = weight_curve.curve.sample(val)
	return val

func _emit_sampled_weight(raw_weight: float):
	on_mode_weight_changed.emit(_sample(raw_weight))
