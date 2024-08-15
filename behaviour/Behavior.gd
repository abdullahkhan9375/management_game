extends Node

class_name Behavior

# Attributes
var behaviour_name: String
var value: float = 100.0  # Current value of the behavior
var decay_rate: float = 0.1  # Rate at which the behavior decays
var threshold: float = 30.0  # Threshold at which the behavior triggers an action
var max_value: float = 100.0  # Maximum value for the behavior

# Signals
signal threshold_breached(work_needed)  # Signal emitted when threshold is breached

func _on_tick():
	value -= decay_rate
	if value < 0:
		value = 0
	check_threshold()
	print("ticking behaviour %s", [behaviour_name])
# Function to check if the value is below the threshold
func check_threshold():
	if value <= threshold:
		emit_signal("threshold_breached", behaviour_name, max_value - value)

# Function to replenish the behavior value
func replenish(amount: float):
	value += amount
	if value > max_value:
		value = max_value  # Ensure value doesn't exceed max_value
	print("Behavior replenished. Current value: ", value)
