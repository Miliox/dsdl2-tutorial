import std.stdio;
import derelict.sdl2.sdl;

// Original C version at:
// http://lazyfoo.net/tutorials/SDL/01_hello_SDL/index2.php

immutable int SCREEN_WIDTH = 800;
immutable int SCREEN_HEIGHT = 600;

void waitClose() {
    SDL_Event event;
    for (;;) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                return;
            }
        }
        SDL_Delay(50);
    }
}

void main()
{
    DerelictSDL2.load();

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        writefln("SDL could not initialize! SDL_Error: %s", SDL_GetError());
    } else {
        SDL_Window* window = SDL_CreateWindow("SDL Tutorial", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
        if (window == null) {
            writefln("Window could not be created! SDL_Error: %s", SDL_GetError());
        } else {
            SDL_Surface* surface = SDL_GetWindowSurface(window);
            SDL_FillRect(surface, null, SDL_MapRGB(surface.format, 0xff, 0xff, 0xff));
            SDL_UpdateWindowSurface(window);

            waitClose();

            SDL_DestroyWindow(window);
        }
    }

    SDL_Quit();
}
