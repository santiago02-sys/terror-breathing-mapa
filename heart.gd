extends Polygon2D

@onready var heartbeat_sound = $HeartbeatSound

var normal_scale := Vector2(1, 1)
var beat_scale := Vector2(1.25, 1.25)
var beating := false

func beat():
	if beating:
		return

	beating = true
	scale = beat_scale
	heartbeat_sound.play()

	await get_tree().create_timer(0.12).timeout

	scale = normal_scale
	beating = false
