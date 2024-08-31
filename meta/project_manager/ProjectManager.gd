extends Node

class_name ProjectManager

func _ready():
	get_parent().get_node("Clock").connect("tick", _on_tick)

func assign_to_all():
	var cservice = get_parent().get_node("CharacterService")
	var characters = cservice.get_characters()
	var work: Project = create_project("Project1", 200)
	for character in characters:
		character.scheduler.task_manager.add_task(work)

func create_project(name, work_units):
	return ProjectFactory.Create(name, work_units) 

func _on_tick(clock_time: ClockTime):
	pass
