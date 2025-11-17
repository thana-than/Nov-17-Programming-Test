extends Node
class_name GradientSampleSignaller

@export var evaluateGradient : Gradient

signal on_sample(color : Color)

func sample(weight : float):
	var color := evaluateGradient.sample(weight)
	on_sample.emit(color)
	return color
