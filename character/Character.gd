extends BaseCharacter 

class_name Character

var state: CharacterStateManager;
var task_manager: TaskManager;
var intent_manager: IntentManager
var current_task: Task
var IDLE_POSITION = Vector2(274, 376)
var movable: Movable
var block: String = "" 
var scheduler: Dictionary
var scheduler_keys: Array
@export var some_name: String

func _init():
	super._init(some_name)
	scheduler =  {
		8: "Sleep",
		12: "Eat",
		14: "Work",
		15: "Rest",
		18: "Leisure"
	}
	scheduler_keys = scheduler.keys()
	scheduler_keys.sort()

func get_block(hour):
	var keys = scheduler_keys
	if (block == ""):
		return scheduler[keys[0]]
	for idx in range(len(keys) - 1):
		var i = keys[idx]
		var j = keys[idx + 1]
		if (hour >= i and hour < j):
			return scheduler[i]
		elif (hour >= keys[-1]):
			return scheduler[keys[-1]]
	return block

func _ready():
	state = CharacterStateManager.new($AnimatedSprite2D);
	task_manager = TaskManager.new(some_name)
	intent_manager = IntentManager.new(task_manager, some_name)
	var clock = get_parent().get_node("Clock")
	clock.connect("tick", _on_tick)
	movable = get_node("Movable")

func do_task():
	var is_legal = current_task.type == block  
	if (!is_legal):
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
	print("character on hour: %s", [hour])
	block = get_block(hour)
	intent_manager._on_tick(hour)