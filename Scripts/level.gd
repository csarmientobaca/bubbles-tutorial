extends Node2D


@onready var spawn_points = $BubbleSpawnPoints

var bubble_scene = preload("res://Scenes/Bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Spawning bubble")
	spawn_bubble()

func spawn_bubble() -> void:
	var markers = spawn_points.get_children()
	print(markers)
	var random_marker = markers.pick_random()
	var bubble = bubble_scene.instantiate()
	add_child(bubble)

	bubble.global_position = random_marker.global_position

	bubble.collected.connect(_on_bubble_collected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bubble_collected() -> void:
	await get_tree().create_timer(2.0).timeout
	spawn_bubble()
