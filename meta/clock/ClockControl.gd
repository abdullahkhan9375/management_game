extends Node

var clock_time_label_text: String;
var clock_label_node: Label;
var clock: Clock
# Called when the node enters the scene tree for the first time.
func _ready():
	clock = get_parent().get_parent().get_node("Clock")
	# print("%s", [clock])
	clock.connect("tick", update_time)
	clock_label_node = get_node("TextureRect").get_node("ClockTimeLabel")
	pass # Replace with function body.

func update_time(clock_time: ClockTime):
	clock_label_node.text = clock_time.to_string()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
