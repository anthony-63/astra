module content::osu;

import std::collections::list;
import std::io::file;
import std::io;
import sections;

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

macro parse_key_value_line(section, String line, String seperator) {
    String[] pair = line.split(seperator);
    
    if(line.starts_with("//") || pair.len < 2) return;
    pair[0].convert_ascii_to_lower();
    
    $foreach ($a: $typeof(section).membersof)
        if(pair[0] == $a.nameof) {
            $switch($a.typeid)
                $case String:
                    section.$eval($a.nameof) = pair[1];
                $case int:
                    section.$eval($a.nameof) = pair[1].to_int()!;
                $case float:
                    section.$eval($a.nameof) = pair[1].to_float()!;
            $endswitch
            io::printfn("%s: %s", $a.nameof, pair[1]);
        }
    $endforeach
}

macro parse_key_value_section(BeatmapParser* parser, section, String name, String seperator) {
    if(!parser.index_to_section(name)) return;
    while(!parser.is_end_of_section()) {
        parse_key_value_line(section, parser.lines[parser.index], seperator);
        parser.index += 1;
    }
}

fn void BeatmapParser.parse(&this) {
    parse_key_value_section(this, this.map.general, "[General]", ": ");
    parse_key_value_section(this, this.map.metadata, "[Metadata]", ":");
    parse_key_value_section(this, this.map.difficulty, "[Difficulty]", ":");
}

fn bool BeatmapParser.index_to_section(&this, String section_name) @private {
    foreach(i, v: this.lines) {
        if(v == section_name) {
            this.index = i + 1;
            io::printfn("Found section %s at %d", section_name, this.index);
            return true;
        }
    }
    io::printfn("Failed to find section %s", section_name);
    return false;
}

fn bool BeatmapParser.is_end_of_section(this) @private {
    return this.index >= this.lines.len() || this.lines[this.index].starts_with("[") || this.lines[this.index].ends_with("]");
}

fn void BeatmapParser.free(this) {
    this.lines.free();
}