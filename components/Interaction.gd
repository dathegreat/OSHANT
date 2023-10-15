extends Area3D
class_name InteractableGame
@export_enum("next_level", "dialogue", "trigger") var interaction_type : int

func interact():
	print("I ", self.name, " am interacting!")
	match interaction_type:
		0:
			print("going to next level")
		1:
			print("dialogue")
		2:
			print("trigger")
