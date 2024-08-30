module content::osu;

import std::collections::list;
import std::io::file;
import std::io;

struct BeatmapParser {
    Beatmap* map;
    usz index;
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
        if(try line = io::treadline(&file)) {
            parser.lines.push(line);
        }
    }

    return parser;
}

fn void BeatmapParser.parse(this) {
    this.parse_general();
}

fn void BeatmapParser.parse_general(this) @private {
    if(!this.index_to_section("[General]")) return;
}

fn bool BeatmapParser.index_to_section(this, String section_name) @private {
    foreach(i, v: this.lines) {
        if(v == section_name) {
            this.index = i;
            std::io::printfn("Found section %s", section_name);
            return true;
        }
    }
    std::io::printfn("Failed to find section %s", section_name);
    return false;
}

fn bool BeatmapParser.is_end_of_section(this) @private {
    return this.index >= this.lines.len() || this.lines[this.index].starts_with("[") || this.lines[this.index].ends_with("]");
}

fn void BeatmapParser.free(this) {
    this.lines.free();
}