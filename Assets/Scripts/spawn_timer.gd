extends Timer

@export var min_time: float = 1.0
@export var max_time: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_time()
	timeout.connect(spawn_time)


func spawn_time():
	set_wait_time(randf_range(min_time, max_time))
