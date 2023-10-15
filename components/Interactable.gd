extends Node

@export_enum("Switch", "Button", "Talk") var interaction_type : int
@onready  var object_to_toggle : Node = $InteractionHolder


var loaded_interaction_indicator : Node

func _on_interact():
	if object_to_toggle.has_method("interact"):
		object_to_toggle.interact()
	#print("Hey, I am interacting! " + self.name)
	match interaction_type:
		0:
			print("I'm a switch")
		1:
			print("I'm a button")
		2:
			print("I'm a talk")

