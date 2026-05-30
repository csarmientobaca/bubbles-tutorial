extends Area2D

@export var oxygen_amount: int = 10
@export var fall_speed: float = 100.0

@export var bottom_limit: float = 750.0

signal collected
signal expired

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position.y += fall_speed * delta

	if position.y > bottom_limit:
		expired.emit()
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_oxygen"):
		body.add_oxygen(oxygen_amount)
		collected.emit()
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
