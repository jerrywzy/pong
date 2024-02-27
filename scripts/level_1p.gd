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
	if is_instance_valid($Paddle_AI) and is_instance_valid($Ball):
		run_AI()
	update_score()
	
	if Input.is_action_just_pressed("pause"):
		paused = not paused
		pause_game()
	
func spawn_ball():
	var ball = ball_scene.instantiate()  # instantiate scene to a variable 'ball'
	add_child(ball)
	ball.name = "Ball"
	$Ball.position = $Spawn.position
	$Ball.connect("player_paddle_bounce", AI_on)
	$Ball.connect("AI_paddle_bounce", AI_off)
	
func reset_ball():
	$Ball.position = $Spawn.position  # (580, 330)
	var direction_x = [-1, 1][randi() % [-1, 1].size()]  # random index from array
	var direction_y = randf_range(-0.8, 0.8) 
	$Ball.velocity.x = direction_x * $Ball.speed
	$Ball.velocity.y = direction_y * $Ball.speed
	AI_computing = true
	$Sound_Buzzer.play()

func update_score():
	$UI/Player1Score.text = str(p1_score)
	$UI/Player2Score.text = str(p2_score)

func _on_left_score_area_area_entered(area):
	p2_score += 1
	await get_tree().create_timer(1).timeout
	reset_ball()

func _on_right_score_area_area_entered(area):
	p1_score += 1
	await get_tree().create_timer(1).timeout
	reset_ball()
	
func run_AI():
	var paddle = $Paddle_AI
	var ball = $Ball
	var direction = 0
	if AI_computing:  # only compute if ball hit by a OTHER Paddle 
		if ball.position.y < paddle.position.y:   # if ball is lower, paddle go down
			direction = -1
		if ball.position.y > paddle.position.y:   # if ball is higher, paddle go up
			direction = 1
		if direction:
			paddle.velocity.y = direction * paddle.speed
		paddle.move_and_slide()

func AI_on():
	AI_computing = true

func AI_off():
	AI_computing = false

func pause_game():
	if not paused:
		pause_menu.hide()
		Engine.time_scale = 1
	elif paused:
		pause_menu.show()
		Engine.time_scale = 0


func _on_start_timer_timeout():
	$UI/Countdown.hide()
