class_name ShootingUnit
extends LivingUnit

@export var MyBullet: PackedScene
@export var Muzzle: PackedScene
var can_shoot: bool
var left_gun: Marker2D
var right_gun: Marker2D


func _init():
	can_shoot = true


func _ready():
	super()
	left_gun = $LeftGun
	right_gun = $RightGun


func _on_shoot_cooldown_timeout():
	can_shoot = true


func shoot(gun, side):
	var bullet := MyBullet.instantiate() as Bullet
	bullet.position = gun.global_position
	bullet.side = side
	get_tree().current_scene.add_child(bullet)	
	var muzzle_flash = Muzzle.instantiate() as MuzzleParticle
	muzzle_flash.position = gun.global_position
	get_tree().current_scene.add_child(muzzle_flash)
