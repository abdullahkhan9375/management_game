extends BaseCharacter 

class_name Character

var state: CharacterStateManager;
var task_manager: TaskManager;
var intent_manager: IntentManager
var current_task: Task

func _init():
	super._init("Bob")

func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	task_manager = TaskManager.new()
	intent_manager = IntentManager.new(task_manager)

func do_task():
	print("doing task %s", [current_task.task_name])
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task")
		return
	self.global_position = interactable.position
	state.on_busy()

func get_task():
	return current_task

func task_control(status: Task.TASK_STATE):
	if (status == Task.TASK_STATE.COMPLETED):
		task_manager.remove_task(current_task.type)
		current_task = null
		self.global_position = Vector2(274, 376)
		state.on_idle()

func _process(delta):
	current_task = task_manager.current_task()
	if (current_task == null or current_task.is_ongoing()): return

	if (state.get_state() == "IDLE"):
		do_task()

func _on_tick():
	intent_manager._on_tick()