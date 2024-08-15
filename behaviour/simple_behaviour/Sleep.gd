extends Behavior

class_name SleepBehavior

func _init():
	# Customize the decay rate, threshold, and max value for sleep
	behaviour_name = "sleep"
	decay_rate = 5
	threshold = 90
	max_value = 100.0

func replenish(amount: float):
	super.replenish(amount)
	print("Sleep replenished. Current value: ", value)
	
