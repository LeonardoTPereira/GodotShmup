class_name LivingUnit
extends CharacterBody2D

@export var health: int = 1
@export var Explosion: PackedScene
var sprite: Sprite2D
var sprite_rect: Rect2


func _ready():
	material = material.duplicate()
	sprite = $Sprite2D
	sprite_rect = sprite.get_rect()


func hit(damage):
	health = max(health-damage, 0)
	if health == 0:
		die()
		return
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE


func set_percent(percentage: float) -> void:
	material.set_shader_parameter('percentage', percentage)


func explode():
	var explosion = Explosion.instantiate() as ExplosionParticle
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)


func burn():
	var texture = NoiseTexture2D.new()
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.frequency = 0.032
	texture.noise = noise
	await texture.changed
	material.set_shader_parameter("burn_texture", texture)
	var tween = create_tween()
	tween.tween_method(set_percent, 1.0, 0.0, 0.5)
	tween.tween_callback(queue_free)


func die():
	$CollisionPolygon2D.set_deferred("disabled", true)
	await get_tree().process_frame
	explode()
	burn()
