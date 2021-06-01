extends GridContainer

var inventory = preload("res://Inventory.tres")

func _ready():
	inventory.connect("items_changed",self, "on_item_changed")
	inventory.make_items_unique()
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slots_display(item_index)

func update_inventory_slots_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)

func on_item_changed(indexes):
	for item_index in indexes:
		update_inventory_slots_display(item_index)

func _unhandled_input(event):
	if event.is_action_released("left_mouse"):
		if inventory.drag_data is Dictionary:
			inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)
