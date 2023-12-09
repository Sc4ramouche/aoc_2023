# Advent of Code 2023

### Notes 

* There are no `main` entry points in OCaml programs. Every program is a top-to-bottom source file, which can be compiled separately.
   * This is what allows me to organise this project neatly. I can execute `dune exec day_2 --watch` and only the contents of this programs will be compiled and executed.
   * I also ran into an issue, when I had nested `dune` files in the repo. It turns out, that the project is determined by the topmost `dune` file found. This caused me to have problems finding input files, as my starting point was higher up in the directory, thus leading to incorrect paths.
* Neovim – you can do `set: wrap` to enforce line wrapping. Useful in markdown files, I should perhaps add it as a default setting to `.md` files.
