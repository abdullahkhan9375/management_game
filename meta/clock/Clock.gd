extends Node
class_name Clock 

# Declare signals for the tick event and new day event

var timer: Timer
@export var INTERVAL = 0.05 # Interval in seconds representing one "minute" in the game

# Variables to keep track of the time
var current_hour: int = 0
var current_minute: int = 0
var current_day: int = 1

var clock_time: ClockTime

var clock_label_node;

signal new_day
signal tick(clock_time: ClockTime)
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	timer.wait_time = INTERVAL
	clock_time = ClockTime.new()
	timer.start()

func set_tick_interval(interval_in_seconds: float):
	timer.stop()
	timer.wait_time = interval_in_seconds
	timer.start()

func _on_timer_timeout():
	current_minute += 1

	if current_minute >= 60:
		current_minute = 0
		current_hour += 1
		
		if current_hour >= 24:
			current_hour = 0
			current_day += 1
	

	clock_time.set_time(current_day, current_hour, current_minute)
	emit_signal("tick", clock_time)

func reset_clock():
	current_hour = 0
	current_minute = 0
	current_day = 1
