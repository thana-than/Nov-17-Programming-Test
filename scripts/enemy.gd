extends CharacterBody2D

@export var attack_force := 1000.0

@export var detect_warmup := 5.0
@export var detect_cooldown := 1.0
@export var patrol_direction := 1.0

@export var speed = 200.0
@onready var head : Node2D = $"Head"
@onready var raycasts : MultiRaycasts = $"Head/TargetDetection"
@onready var edge_detection : RayCast2D = $"EdgeDetection"

signal on_attack_weight_changed(weight : float)

var attack_weight := 0.0:
	set(value):
		var prev = attack_weight
		attack_weight = value
		if attack_weight != prev:
			on_attack_weight_changed.emit(attack_weight)
	
func direction_state_pass(delta: float) -> float:
	var target_obj = raycasts.get_collider() as Node2D

	if target_obj:
		attack_weight = move_toward(attack_weight, 1.0, detect_warmup * delta)
		if attack_weight >= 1.0:
			return sign(target_obj.position.x - position.x)
	
	if attack_weight > 0.0:
		attack_weight = move_toward(attack_weight, 0.0, detect_cooldown * delta)
		return 0.0
		
	return patrol_direction
	
func direction_edge_pass(direction : float):
	if direction == 0.0:
		return direction
	
	var s_dir = sign(direction)
	edge_detection.position = Vector2(s_dir * abs(edge_detection.position.x),edge_detection.position.y)
	edge_detection.force_raycast_update()
	if edge_detection.is_colliding():
		return direction
	
	patrol_direction = -s_dir
	return 0.0
	
func collision_check() -> void:
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is PlayerCharacterBody2D:
			collider.hit(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction := direction_state_pass(delta)
	direction = direction_edge_pass(direction)
	
	if direction:
		velocity.x = direction * speed
		head.scale = Vector2(sign(direction), 1.0)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	collision_check()
