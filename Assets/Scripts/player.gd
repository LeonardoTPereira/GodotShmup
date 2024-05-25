extends ShootingUnit
class_name Player

signal healthChanged
signal gameOver
@export var speed: float = 300


func _ready():
	super()
	healthChanged.emit(health)


func _physics_process(_delta):
	
	var movement := Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		movement.y = -1
	if Input.is_action_pressed("Down"):
		movement.y = 1
	if Input.is_action_pressed("Left"):
		movement.x = -1
	if Input.is_action_pressed("Right"):
		movement.x = 1

	movement = movement.normalized()
	velocity = movement*speed

	move_and_slide()
	
	global_position.x = clamp(global_position.x, 0 + sprite_rect.size.x/2,
			get_viewport().get_visible_rect().size.x-sprite_rect.size.x/2)
	global_position.y = clamp(global_position.y, 0 + sprite_rect.size.y/2, 
			get_viewport().get_visible_rect().size.y - sprite_rect.size.y/2)


func hit(damage):
	super(damage)
	healthChanged.emit(health)


func _process(_delta):
	if Input.is_action_pressed("Shoot") and can_shoot:
		shoot(left_gun, false)
		shoot(right_gun, true)
		$ShootCooldown.start()
		can_shoot=false


func die():
	gameOver.emit()
	super()
