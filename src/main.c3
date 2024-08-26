module astra;
import std::io;

import app;

fn int main(String[] args) {
	app::Astra astra = app::astra_init("osu!astra", 1280, 720);
	astra.run();
	astra.close();

	return 0;
}
