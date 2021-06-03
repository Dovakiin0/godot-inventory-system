extends Node2D

var item_name
var item_quantity

func _ready():
	pass

func set_item(itn, itq):
	item_name = itn
	item_quantity = itq
	$TextureRect.texture = load("res://Assets/Items/" + JsonData.item_data[item_name].texture + ".png")
	var stack_size = int(JsonData.item_data[item_name].stack_size)
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = str(item_quantity)

func add_item_quantity(amt_to_add):
	item_quantity += amt_to_add
	$Label.text = str(item_quantity)

func decrease_item_quantity(amt_to_sub):
	item_quantity -= amt_to_sub
	$Label.text = str(item_quantity)
