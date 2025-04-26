extends VBoxContainer

@export var item_value: String = "-":
    set(value):
        if value != "":
            item_value = value
            update_score()
        else:
            item_value = "-"
            update_score()

func _ready():
    $item_name.text = capitalize_first_letter(self.name)

func update_score():
    $item_value.text = item_value

func capitalize_first_letter(text: String) -> String:
    if text.length() == 0:
        return text
    return text.substr(0, 1).to_upper() + text.substr(1)
