extends Label

@export var fade_duration: float = 0.2

var _current_text: String = ""
var _active_tween: Tween

func _ready():
    _current_text = text
    modulate.a = 1.0

func set_title(new_text: String):
    if new_text == _current_text:
        return

    if _active_tween and _active_tween.is_valid():
        _active_tween.kill() # kill() でTweenを即座に停止

    _fade_out_then_in(new_text)

func _fade_out_then_in(new_text: String) -> void:
    # 新しいTweenを作成し、変数に保持する
    # create_tween() はデフォルトで sequential (順番に実行) になります
    _active_tween = get_tree().create_tween()

    _active_tween.tween_property(self, "modulate:a", 0.0, fade_duration/2)

    # テキスト変更: フェードアウトが終わったタイミングで _change_text を呼び出す
    #    bind() を使って、呼び出す関数に new_text を渡す
    _active_tween.tween_callback(_change_text.bind(new_text))
    _active_tween.tween_property(self, "modulate:a", 1.0, fade_duration/2)

# テキストを変更し、内部の状態も更新する関数
func _change_text(new_text: String) -> void:
    text = new_text          # Labelのテキストを更新
    _current_text = new_text # 内部で保持しているテキストも更新
