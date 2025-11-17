extends CanvasItem

@export_range(0.0,1.0) var alpha := 1.0:
	get:
		return modulate.a
	set(value):
		var c := Color.WHITE
		c.a = value
		modulate = c

func set_alpha(a : float):
	alpha = a
