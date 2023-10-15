extends CanvasLayer
@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready() -> void:
	EventBus.playerHealth.connect(show_health)

func show_health(health: int):
	rich_text_label.text = "health: " + str(health)
