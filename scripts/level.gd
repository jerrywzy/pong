extends Node2D

var ball_scene: PackedScene = load("res://scenes/ball.tscn")   # load PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var ball = ball_scene.instantiate()  # instantiate scene to a variable 'ball'
	add_child(ball)  # add ball to tree
	ball.position = $Spawn.position  # (580, 330)
	ball.connect("offscreen", reset_ball)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func reset_ball():
	var ball = ball_scene.instantiate()  # instantiate scene to a variable 'ball'
	add_child(ball)  # add ball to tree
	ball.position = $Spawn.position  # (580, 330)
	ball.connect("offscreen", reset_ball)

