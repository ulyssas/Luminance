extends Node

@export var game_scene: PackedScene

func _ready():
    var music_folder = OS.get_user_data_dir().path_join("musics")
    
    # 初回起動時に `music` フォルダを作成
    if not DirAccess.dir_exists_absolute(music_folder):
        DirAccess.make_dir_absolute(music_folder)
        print("📂 'musics' フォルダを作成しました: ", music_folder)
    else:
        print("📂 'musics' フォルダがすでに存在します: ", music_folder)

func _on_folder_open_button_up():
    """`musics` フォルダを開く"""
    var music_folder = OS.get_user_data_dir().path_join("musics")
    OS.shell_open(music_folder)


func _on_game_open_button_up():
    """`game` を開く"""
    if game_scene == null:
        print("シーンが設定されていません")
        return
    
    var game_instance = game_scene.instantiate()
    var music_list = MusicRead.load_music_data()
    
    if music_list.size() > 0:
        game_instance.set_music_data(music_list[0])  # 最初のデータを渡す

    get_tree().root.add_child(game_instance)
    get_tree().current_scene.queue_free()
    get_tree().current_scene = game_instance
