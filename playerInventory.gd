extends Node

signal active_item_updated

const MAX_SLOTS = 20
const MAX_HOTBAR = 8
const SlotClass = preload("res://Slot.gd")
const ItemClass = preload("res://Item.gd")

var inventory = {
	0: ["potion", 2],
}

var hotbar = {
	1: ["potion", 24],
}

var equips = {
	0: ["leather_head", 1]
}

var active_item = 0

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name].stack_size)
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])				
				item_quantity = item_quantity - able_to_add
	for i in range(MAX_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])			
			return
	

func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().root.get_node("/root/World/UserInterface/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)

func remove_item(slot: SlotClass):
	match slot.slot_type:
		SlotClass.SlotType.HOTBAR:
			hotbar.erase(slot.slot_index)
		SlotClass.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
		_:
			equips.erase(slot.slot_index)
	
func add_item_quantity(slot: SlotClass, quantity: int):
	match slot.slot_type:
		SlotClass.SlotType.HOTBAR:
			hotbar[slot.slot_index][1] += quantity
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index][1] += quantity
		_:
			equips[slot.slot_index][1] += quantity
	
func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	match slot.slot_type:
		SlotClass.SlotType.HOTBAR:
			hotbar[slot.slot_index] = [item.item_name, item.item_quantity]
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index] = [item.item_name, item.item_quantity]
		_:
			equips[slot.slot_index] = [item.item_name, item.item_quantity]

func active_item_scroll_up():
	active_item = (active_item + 1) % MAX_HOTBAR
	emit_signal("active_item_updated")

func active_item_scroll_down():
	if active_item == 0:
		active_item = MAX_HOTBAR - 1
	else:
		active_item -= 1
	emit_signal("active_item_updated")
