@tool
extends Line2D

var pulse_speed := 250.0
var speed_increase := 50.0
var suspicion_increase := 10.0
var heart_position := 576.0
var perfect_distance := 15.0
var good_distance := 40.0
var speed_decrease := 30.0
var result_text
var heart
var suspicion_bar
var stress_bar


func _ready():
	points = PackedVector2Array([
		Vector2(-40, 0),
		Vector2(-15, 0),
		Vector2(-8, -20),
		Vector2(0, 40),
		Vector2(8, -15),
		Vector2(20, 0),
		Vector2(40, 0)
	])

	position = Vector2(151, 320)

	result_text = get_parent().get_node("ResultText")
	heart = get_parent().get_node("Heart")
	suspicion_bar = get_parent().get_node("SuspicionBar")
	stress_bar = get_parent().get_node("StressBar")


func _process(delta):
	position.x += pulse_speed * delta

	if position.x > 1001:
		position.x = 151


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			var distance = abs(position.x - heart_position)
			
			if distance <= perfect_distance:
				print("¡PERFECTO! ❤️")
				result_text.text = "¡PERFECTO! ❤️"
				stress_bar.value -= 10
				heart.beat()
				suspicion_bar.value -= 10.0

				pulse_speed -= speed_decrease
				pulse_speed = max(pulse_speed, 100.0)
				position.x = 151
				
			elif distance <= good_distance:
				print("¡BIEN! 🟡")
				result_text.text = "¡BIEN! 🟡"
				stress_bar.value -= 5
				position.x = 151
			else:
				print("¡FALLO! 🔴")
				result_text.text = "¡FALLO! 🔴"
				suspicion_bar.value += suspicion_increase
				await get_tree().create_timer(0.15).timeout
				pulse_speed += speed_increase
				stress_bar.value += 10
				print ("nueva velocidad: ", pulse_speed)
				position.x = 151
