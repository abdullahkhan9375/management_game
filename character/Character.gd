extends BaseCharacter 

class_name Character

var state: CharacterStateManager
var ctrl: CharacterControl
var movable: Movable
var scheduler: Scheduler

func _init():
	super._init()
	
func _ready():
	ctrl = CharacterControl.new($Control, self)
	state = CharacterStateManager.new($AnimatedSprite2D);
	movable = $Movable
	movable.connect("on_moving_start", state.on_moving_start)
	movable.connect("on_moving_stop", state.on_moving_stop)
	scheduler.connect("move", movable.move_to)
	scheduler.connect("work_update", ctrl.on_task_update)

func set_clock(clock: Clock):
	scheduler = Scheduler.new(clock, {2: "Work", 6: "Sleep"}, state)
	
func set_character_name(c_name: String):
	self.character_name = c_name

func get_work():
	return scheduler.current_task

