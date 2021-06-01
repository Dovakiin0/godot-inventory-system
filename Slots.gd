extends CenterContainer

var inventory = preload("res://Inventory.tres")

onready var itemSlot = $Slots/Item
onready var itemAmountLabel = $Slots/Item/Amount

"""

arg item = ItemsDatabase.Items.item_name

"""
		
func display_item(item):
	if item != null:
		itemSlot.texture = load_texture(item.texture)
		if item.stackable:
			itemAmountLabel.text = str(item.amount)
		else:
			itemAmountLabel.text = ""
	else:
		itemSlot.texture = null
		itemAmountLabel.text = ""

func get_drag_data(_position):
	var item_index  = get_index()
	var item = inventory.remove_item(item_index)
	if item != null:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.rect_scale = Vector2(0.6,0.6)
		dragPreview.texture = load_texture(item.texture)
		set_drag_preview(dragPreview)
		inventory.drag_data = data
		return data
		
func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	
	if my_item != null and my_item.name == data.item.name:
		if my_item.stackable:
			my_item.amount += data.item.amount
			inventory.emit_signal("items_changed", [my_item_index])
		else:
			inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)
	else:
		inventory.swap_item(my_item_index, data.item_index)
		inventory.set_item(my_item_index, data.item)
	inventory.drag_data = null

func load_texture(name):
	return load("res://Assets/Items/" + name + ".png")

