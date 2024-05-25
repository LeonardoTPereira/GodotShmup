class_name Enemy
extends ShootingUnit

signal defeated
@export var speed: float = 100
@export var score: int = 10


func _physics_process(_delta):
	velocity.y = speed
	move_and_slide()


func _on_shoot_cooldown_timeout():
	can_shoot = true
	shoot(left_gun, false)
	shoot(right_gun, true)
	$ShootCooldown.start()
	can_shoot=false


func die():
	defeated.emit(score)
	super()
