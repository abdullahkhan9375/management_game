extends BaseCharacter 

class_name Character

var state: CharacterStateManager;
var task_manager: TaskManager;
var intent_manager: IntentManager
var scheduler: Scheduler
var clock: Clock = null
var current_task: Task
var IDLE_POSITION = Vector2(274, 376)
var movable: Movable
var some_name: String

func _init():
	some_name = "Toby"
	super._init(some_name)
	
func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	task_manager = TaskManager.new(some_name)
	intent_manager = IntentManager.new(task_manager, some_name)
	movable = get_node("Movable")
	scheduler = Scheduler.new({6: "Sleep", 12: "Work", 4: "Work"})

func set_clock(clock: Clock):
	self.clock = clock
	clock.connect("tick", _on_tick)

func do_task():
	if (!scheduler.is_in_schedule(current_task.type)):
		return
	state.on_busy()
	var interactable = Interactable.find_interactable(get_tree(), current_task.type)	
	if (interactable == null):
		print("could not find interactable for task")
		return
	movable.move_to(interactable.position)

func get_task():
	return current_task

func task_control(task: Task):
	var status = task.state
	if (status == Task.TASK_STATE.COMPLETED):
		task_manager.remove_task(task.type)
		current_task = null
		movable.move_to(IDLE_POSITION)
		state.on_idle()
	elif (status == Task.TASK_STATE.ONGOING):
		state.on_busy()
	
func _process(delta):
	current_task = task_manager.current_task()
	if (state.get_state() == "IDLE" and current_task != null):
		do_task()

func _on_tick(hour):
	scheduler.update(hour)
	intent_manager._on_tick(hour)
