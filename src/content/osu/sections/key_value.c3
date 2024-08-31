module sections;

import std::io;

macro parse_key_value_line($section, String line, String seperator) {
    String[] pair = line.split(seperator);
    
    if(line.starts_with("//") || pair.len < 2) return;

    $foreach ($a: $typeof(section).membersof)
        io::printfn("a.nameof: %s", $a.nameof);
        if(pair[0] == $a.nameof) {
            io::printfn("%s", $a.nameof);
        }
    $endforeach
}