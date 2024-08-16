extends BaseCharacter 

class_name Character

var state: CharacterStateManager;
var task_manager: TaskManager;
var intent_manager: IntentManager
var current_task: Task
var IDLE_POSITION = Vector2(274, 376)
var target_position = IDLE_POSITION
var movable: Movable
@export var some_name: String

func _init():
	super._init(some_name)

func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	task_manager = TaskManager.new(some_name)
	intent_manager = IntentManager.new(task_manager, some_name)
	var scheduler = get_parent().get_node("Scheduler")
	scheduler.connect("tick", _on_tick)
	movable = get_node("Movable")

func do_task():
	print("doing task %s", [current_task.task_name])
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task")
		return
	movable.set_target_position(interactable.position)
	movable.move()
	state.on_busy()

func get_task():
	return current_task

func task_control(status: Task.TASK_STATE):
	if (status == Task.TASK_STATE.COMPLETED):
		task_manager.remove_task(current_task.type)
		state.on_idle()
		current_task = null
		movable.set_target_position(IDLE_POSITION)
		movable.move()
	elif (status == Task.TASK_STATE.ONGOING):
		state.on_busy()
	
func _process(delta):
	current_task = task_manager.current_task()
	if (state.get_state() == "IDLE" and current_task != null):
		do_task()

func _on_tick():
	intent_manager._on_tick()
