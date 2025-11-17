extends Node2D
class_name MultiRaycasts

var raycasts : Array[RayCast2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is RayCast2D:
			raycasts.append(child)


func get_collider() -> Object:
	for r in raycasts:
		var obj = r.get_collider()
		if obj:
			return obj
	return null
