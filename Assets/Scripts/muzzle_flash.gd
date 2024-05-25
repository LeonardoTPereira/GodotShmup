extends CPUParticles2D
class_name MuzzleParticle

func _ready():
	emitting = true
	

func _process(_delta):
	if emitting == false:
		queue_free()
