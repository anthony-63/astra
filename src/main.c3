module astra;
import std::io;

import app;
import content::osu;

fn int main(String[] args) {
	// app::Astra astra = app::astra_init("osu!astra", 1280, 720);
	// astra.run();
	// astra.close();

	BeatmapSet! mapset = osu::open_beatmapset("C:/Users/antho/AppData/Local/osu!/Songs/991300 Fleshgod Apocalypse - The Deceit");
	
	return 0;
}
