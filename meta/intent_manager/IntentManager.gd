extends Node

class_name IntentManager
var behaviors: Array = []

func init_behaviors(li):
	li.push_back(SleepBehavior.new())
	
func _ready():
	init_behaviors(behaviors)
	for behav in behaviors:
		add_child(behav)
		behav.threshold_breached.connect(_on_threshold_breached)
	print("intent manager initialized")

func _on_threshold_breached(behavior_name, work_needed):
	$TaskManager.register_breached_behavior(behavior_name, work_needed)

func _on_tick():
	for behav in behaviors:
		behav._on_tick();
	print("behaviors ticked!")

# Example function to handle or process all breached behaviors (if needed)
func process_breached_behaviors():
	for child in get_children():
		if child is Behavior and child.value <= child.threshold:
			print("Processing breached behavior: ", child.name)
			# Handle the breached behavior here (e.g., trigger a specific task)