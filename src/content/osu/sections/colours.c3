module sections;

import sdl3;

import std::collections::list;
import std::io;

struct BeatmapColoursSection {
    List(<ComboColour>) colours;
}

struct ComboColour {
    usz index;
    sdl3::Color color;
}

fn void BeatmapColoursSection.parse_line(this, String line) {
    String[] combo_info = line.split(" : ");
    if(combo_info.len != 2 || line.starts_with("//")) return;

    usz index = (usz)combo_info[0].trim("Combo").to_long()!!;
    String[] color_info = combo_info[1].split(",");
    char r = (char)color_info[0].to_int()!!;
    char g = (char)color_info[1].to_int()!!;
    char b = (char)color_info[2].to_int()!!;
    this.colours.push(ComboColour {
        .index = index,
        .color = sdl3::Color {
            .r = r, .g = g, .b = b, .a = 255,
        }
    });
}