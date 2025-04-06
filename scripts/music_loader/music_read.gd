extends Node

const MusicData = preload("res://scripts/music_loader/music_data.gd")
const LevelData = preload("res://scripts/music_loader/level_data.gd")
const MeasureData = preload("res://scripts/music_loader/measure_data.gd")
const DivisionData = preload("res://scripts/music_loader/division_data.gd")

func load_music_data(source: String) -> Array[MusicData]:
    var music_data_list: Array[MusicData] = []
    var base_path := ""

    # 引数に応じてパスを設定
    match source:
        "user":
            base_path = "user://musics"
        "res":
            base_path = "res://musics"
        _:
            push_error("無効な引数です: 'user' または 'res' を指定してください")
            return music_data_list

    if not DirAccess.dir_exists_absolute(base_path):
        push_error("指定されたディレクトリが存在しません: %s" % base_path)
        return music_data_list

    var dir = DirAccess.open(base_path)
    if dir:
        dir.list_dir_begin()
        var folder_name = dir.get_next()

        while folder_name != "":
            if dir.current_is_dir():
                # レベルを読み込む
                var levels: Array[LevelData] = load_level_data(base_path, folder_name)

                # data.txtを読み込む
                var data_path = "%s/%s/data.txt" % [base_path, folder_name]
                var folder_path = "%s/%s" % [base_path, folder_name]
                var jacket_path = find_jacket_image_path(folder_path)
                var data_file = FileAccess.open(data_path, FileAccess.READ)
                if data_file:
                    var lines = []
                    while not data_file.eof_reached():
                        lines.append(data_file.get_line().strip_edges())

                    if lines.size() >= 9:
                        var data = MusicData.new(
                            lines[0],         # title
                            jacket_path,      # texture_path
                            lines[2],         # composer
                            lines[3],         # note_designer
                            lines[4] == "true",  # has_kuso
                            int(lines[5]),    # priority
                            int(lines[6]),    # sabi_begin
                            int(lines[7]),    # sabi_end
                            float(lines[8]),  # velocity
                            levels
                        )
                        music_data_list.append(data)

            folder_name = dir.get_next()
        dir.list_dir_end()
    # priority順に昇順ソート（小さいほど先に来る）
    music_data_list.sort_custom(func(a: MusicData, b: MusicData) -> bool:
        return a.priority > b.priority
    )

    return music_data_list


func load_level_data(base_path: String, folder_name: String) -> Array[LevelData]:
    const level_names = ["easy", "medium", "hard", "kuso"]
    var levels: Array[LevelData] = []

    for level_name in level_names:
        var file_path = "%s/%s/%s.txt" % [base_path, folder_name, level_name]
        var file = FileAccess.open(file_path, FileAccess.READ)
        if file:
            var lines = []
            while not file.eof_reached():
                lines.append(file.get_line().strip_edges())

            var measures: Array[MeasureData] = []

            # 譜面データ以外の部分
            if lines.size() >= 7:
                var music = LevelData.new(
                    lines[0],         # title
                    lines[1],         # composer
                    lines[2],         # note_designer
                    float(lines[3]),  # bpm
                    level_name,       # level_name
                    lines[4],         # level_value
                    int(lines[5]),    # measure_count
                    float(lines[6]),  # offset
                    measures          # measures
                )
                levels.append(music)

    return levels

#func load_measure_data() -> Array[MeasureData]:
    #pass


# jackets画像の自動検索
func find_jacket_image_path(folder_path: String) -> String:
    var dir = DirAccess.open(folder_path)
    if dir:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if not dir.current_is_dir():
                if file_name.begins_with("jackets") and file_name.get_extension().to_lower() in ["png", "jpg", "jpeg"]:
                    return "%s/%s" % [folder_path, file_name]
            file_name = dir.get_next()
        dir.list_dir_end()
    return ""  # 見つからなければ空文字列を返す
