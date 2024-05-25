extends CPUParticles2D
class_name ExplosionParticle

func _ready():
	emitting = true
	

func _process(_delta):
	if emitting == false:
		queue_free()
