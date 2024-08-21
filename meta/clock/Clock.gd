extends Node
class_name Clock 

# Declare signals for the tick event and new day event
signal tick(hour: int)
signal new_day

# Reference to the Timer node
var timer: Timer
@export var INTERVAL = 0.05 # Interval in seconds representing one "minute" in the game

# Variables to keep track of the time
var current_hour: int = 0
var current_minute: int = 0
var current_day: int = 1

# Function to set up the timer and connect the signals
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	# Set the timer interval and start it
	timer.wait_time = INTERVAL
	timer.start()

# Function to adjust the tick interval
func set_tick_interval(interval_in_seconds: float):
	timer.stop()
	timer.wait_time = interval_in_seconds
	timer.start()

# Function to handle the timer timeout
func _on_timer_timeout():
	# Increase the time by one "minute"
	current_minute += 1
	
	# Check if an hour has passed
	if current_minute >= 60:
		current_minute = 0
		current_hour += 1
		emit_signal("tick", current_hour)
		print("Time: %02d:%02d" % [current_hour, current_minute])
		
		# Check if a day has passed
		if current_hour >= 24:
			current_hour = 0
			current_day += 1
			emit_signal("new_day")
			

# Function to get the current time
func get_current_time() -> Dictionary:
	return {
		"hour": current_hour,
		"minute": current_minute,
		"day": current_day
	}

# Function to reset the clock (if needed)
func reset_clock():
	current_hour = 0
	current_minute = 0
	current_day = 1
