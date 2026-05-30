extends Node2D


@onready var spawn_points = $BubbleSpawnPoints

@onready var score_label = $CanvasLayer/ScoreLabel

var score = 0

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
	bubble.expired.connect(_on_bubble_expired)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass

func _on_bubble_collected() -> void:
	add_score()
	await get_tree().create_timer(2.0).timeout
	spawn_bubble()

func _on_bubble_expired() -> void:
	remove_score()
	await get_tree().create_timer(2.0).timeout
	spawn_bubble()

func add_score() -> void:
	score += 1
	score_label.text = "Score: " + str(score)

func remove_score() -> void:
	score = max(score - 1, 0)
	score_label.text = "Score: " + str(score)
