module content::osu;

import std::collections::list;
import std::io::file;
import std::io;

struct BeatmapParser {
    Beatmap* map;
    int index;
    List(<String>) lines;
}

fn BeatmapParser new_parser(Beatmap* map, String path) {
    BeatmapParser parser;
    parser.map = map;
    parser.index = 0;

    std::io::printfn("%s", path);
    File file = file::open(path, "r+")!!;
    defer (void)file.close();
    while(!file.eof()) {
        @pool() {
            if(try line = io::treadline(&file)) {
                parser.lines.push(line);
            }
        };
    }

    return parser;
}

fn void BeatmapParser.parse(this) {

}

fn void BeatmapParser.free(this) {
    this.lines.free();
}