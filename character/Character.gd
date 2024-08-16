extends BaseCharacter 

class_name Character

var state: CharacterStateManager;
var task_manager: TaskManager;
var intent_manager: IntentManager
var current_task: Task
var IDLE_POSITION = Vector2(274, 376)
var target_position = IDLE_POSITION
@export var some_name: String

func _init():
	super._init(some_name)

func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	task_manager = TaskManager.new()
	intent_manager = IntentManager.new(task_manager)

func do_task(delta):
	print("doing task %s", [current_task.task_name])
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task")
		return
	target_position = interactable.position

func get_task():
	return current_task

func task_control(status: Task.TASK_STATE):
	if (status == Task.TASK_STATE.COMPLETED):
		task_manager.remove_task(current_task.type)
		state.on_idle()
		current_task = null
	elif (status == Task.TASK_STATE.ONGOING):
		state.on_busy()
	
func move_to_target_position(delta, task):
	if (self.position.distance_to(target_position) >= 1):
		if (state.get_state() != "MOVING"):
			state.on_moving()
		move_to(target_position, delta)
	else:
		self.position = target_position

func _process(delta):
	current_task = task_manager.current_task()
	move_to_target_position(delta, current_task)	
	if (current_task == null):
		target_position = IDLE_POSITION
		return
	if (state.get_state() == "IDLE"):
		print("doing task %s", [self.cname])
		do_task(delta)

func _on_tick():
	intent_manager._on_tick()