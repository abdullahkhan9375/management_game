class_name ProjectFactory

static func Create(name: String, work_units: float):
	return Project.new(work_units, "Work", name) 
