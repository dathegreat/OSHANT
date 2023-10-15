extends Camera3D

func _ready() -> void:
	EventBus.camShake.connect(shakeCamera)

func shakeCamera():
	pass
