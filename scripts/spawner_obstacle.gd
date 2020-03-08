extends Node2D

const scn_obstacle = preload("res://scenes/obstacle.tscn")
const OBSTACLE_WIDTH = 26
const GROUND_HEIGHT = 56
const OFFSET_X = 100
const OFFSET_Y = 55
const AMOUNT_TO_FILL_VIEW = 3

func _ready():
	go_init_pos()
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()
	pass

func go_init_pos():
	randomize()
	var init_pos = Vector2()
	init_pos.x = get_viewport_rect().size.x + OBSTACLE_WIDTH/2
	init_pos.y = rand_range(0+OFFSET_Y, get_viewport_rect().size.y-GROUND_HEIGHT-OFFSET_Y)
	position = init_pos

func spawn_and_move():
	spawn_obstacle()
	go_next_pos()

func spawn_obstacle():
	var new_obstacle = scn_obstacle.instance()
	new_obstacle.position = position
	get_node("container").add_child(new_obstacle)
	new_obstacle.connect("tree_exited", self, "spawn_and_move")
	pass

func go_next_pos():
	randomize()
	var next_pos = position
	next_pos.x += OBSTACLE_WIDTH/2 + OFFSET_X + OBSTACLE_WIDTH/2
	next_pos.y = rand_range(0+OFFSET_Y, get_viewport_rect().size.y-GROUND_HEIGHT-OFFSET_Y)
	position = next_pos
