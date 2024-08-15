extends Node
class_name Scheduler
# Declare a signal for the tick event
signal tick

# Reference to the Timer node
var timer: Timer
@export var INTERVAL = 10;
# Function to set up the timer and connect the signal
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	# Set the timer to trigger every hour (3600 seconds)
	timer.wait_time = INTERVAL
	timer.start()

# Function to adjust the tick interval
func set_tick_interval(interval_in_seconds: float):
	timer.stop()
	timer.wait_time = interval_in_seconds
	timer.start()

# Function to handle the timer timeout
func _on_timer_timeout():
	print("tick")
	emit_signal("tick")
