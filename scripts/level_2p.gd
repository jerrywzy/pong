extends Node2D

var ball_scene: PackedScene = load("res://scenes/ball.tscn")   # load PackedScene
var p1_score: int = 0
var p2_score: int = 0
var AI_computing = true
@onready var pause_menu = $Pause
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/Countdown.show()
	$StartTimer.start()
	await $StartTimer.timeout
	spawn_ball()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/Countdown.text = str(int($StartTimer.time_left))
	update_score()
	
	if Input.is_action_just_pressed("pause"):
		paused = not paused
		pause_game()
	
func spawn_ball():
	var ball = ball_scene.instantiate()  # instantiate scene to a variable 'ball'
	add_child(ball)
	ball.name = "Ball"
	$Ball.position = $Spawn.position

func reset_ball():
	$Ball.position = $Spawn.position  # (580, 330)
	#$SpawnTimer.start()
	#await $SpawnTimer.timeout
	var direction_x = [-1, 1][randi() % [-1, 1].size()]  # random index from array
	var direction_y = randf_range(-0.8, 0.8) 
	$Ball.velocity.x = direction_x * $Ball.speed
	$Ball.velocity.y = direction_y * $Ball.speed
	$Sound_Buzzer.play()

func update_score():
	$UI/Player1Score.text = str(p1_score)
	$UI/Player2Score.text = str(p2_score)

func _on_left_score_area_area_entered(area):
	p2_score += 1
	reset_ball()

func _on_right_score_area_area_entered(area):
	p1_score += 1
	reset_ball()


func pause_game():
	if not paused:
		pause_menu.hide()
		Engine.time_scale = 1
	elif paused:
		pause_menu.show()
		Engine.time_scale = 0


func _on_start_timer_timeout():
	$UI/Countdown.hide()
