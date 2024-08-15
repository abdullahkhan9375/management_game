extends Node2D

class_name Character

var state: CharacterStateManager;
var task_manager: TaskManager;
var intent_manager: IntentManager
var move_speed: int
var cname: String
var current_task: Task

# Called when the node enters the scene tree for the first time.
func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	state.on_idle();
	task_manager = TaskManager.new()
	intent_manager = IntentManager.new(task_manager)
	move_speed = 2
	cname = "Bob"

func get_productivity():
	return 1.0;

func do_task():
	print("doing task %s", [current_task.task_name])
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task")
		return
	else:
		print("interactable found %s", [typeof(interactable)])	
	self.global_position = interactable.position
	state.on_busy()

func get_task():
	return current_task

func task_update(status: int):
	if (status == 1):
		print("back to being idle")
		task_manager.remove_task(current_task.type)
		task_manager.print_tasks()
		current_task = null
		self.global_position = Vector2(0, 0)
		state.on_idle()

func _process(delta):
	current_task = task_manager.current_task()
	if (current_task == null or current_task.is_ongoing()): return

	if (state.get_state() == "IDLE"):
		do_task()

func _on_tick():
	intent_manager._on_tick()