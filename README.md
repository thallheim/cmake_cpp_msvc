# What's all this, then?

A personal time saver.

---

# TODO

- [ ] Write something to gather upp TODOs from sources into one place
- [ ] Reorganise/unclutter config stuff
  - [ ] Move just-related files into subdir(s).
  - [ ] Same for the CMake scripts
- [ ] Try putting Windows logic into a separate pwsh-script and calling that from just

## justfile(s?)

- [ ] Clean up unused vars
- [x] cp the virgin justfile pre-config so it can be reset from a cmake script/just
  - Exclude from any contexts?


## Windows slowdowns
_Later - switching back to Git bash under Win will do for now._

Doesn't seem to be the files at issue. To check:
 - Is some back-asswards Windows convention spawning new shells?
 - Do I not propagate the set shell?
 - Time a CMake script invocation in isolation, because Windows
