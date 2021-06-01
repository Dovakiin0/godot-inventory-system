extends Node

var inventory = preload("res://Inventory.tres")

var random_items = [
	'sword','potion','diamond_ring','tail_shield','sword','potion','diamond_ring','tail_shield','sword','potion','diamond_ring','tail_shield','sword','potion','diamond_ring','tail_shield'
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	random_items.shuffle()
	for item in random_items:
		inventory.set_item(randi() % 27, ItemsDatabase.Items[item])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
