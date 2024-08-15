extends Node

class_name Behavior

# Attributes
var behavior_name: String = ""
var value: float = 100.0  # Current value of the behavior
var decay_rate: float = 0.1  # Rate at which the behavior decays
var threshold: float = 30.0  # Threshold at which the behavior triggers an action
var max_value: float = 100.0  # Maximum value for the behavior

# Signals
signal threshold_breached(behavior)

func _on_tick():
	value -= decay_rate
	if value < 0:
		value = 0
	check_threshold()

func check_threshold():
	if value <= threshold:
		emit_signal("threshold_breached", self)

# Function to replenish the behavior value
func replenish_full():
	value = max_value
	print("behavior replenished")

func replenish(amount: float):
	value += amount
	if value > max_value:
		value = max_value  # Ensure value doesn't exceed max_value
	print("behavior replenished. Current value: ", value)
