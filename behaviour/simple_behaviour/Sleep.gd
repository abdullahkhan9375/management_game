extends Behavior

class_name SleepBehavior

func _init():
	# Customize the decay rate, threshold, and max value for sleep
	behavior_name = "Sleep"
	decay_rate = 5
	threshold = randi() % 10 + 70
	max_value = randi() % 31 + 90
