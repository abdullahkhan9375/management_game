class_name ClockTime

var day: int
var hour: int
var minute: int

# Constructor
func _init(day := 0, hour := 0, minute := 0):
    self.day = day
    self.hour = hour
    self.minute = minute

# Setter function to set time
func set_time(day: int, hour: int, minute: int):
    self.day = day
    self.hour = hour
    self.minute = minute

# Getter functions
func get_day() -> int:
    return day

func get_hour() -> int:
    return hour

func get_minute() -> int:
    return minute

# Custom to_string function to display time as HH:MM
func _to_string(): return "%02d:%02d" % [hour, minute]
