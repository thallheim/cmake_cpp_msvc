# What's all this, then?

A personal time saver.

# TODO


## justfile(s?)

- [ ] Clean up unused vars
- [ ] Should the OG justfile be templated as well, so I can have a
    recipe for resetting the justfile(s)?


## Misc.

- [ ] Write something to gather upp TODOs from sources into one place
- [ ] Move just-related files into subdir(s).

### Windows slowdowns
_Later - switching back to Git bash under Win will do for now._

Doesn't seem to be the files at issue. To check:
 - Is some back-asswards Windows convention spawning new shells?
 - Do I not propagate the set shell?
 - Time a CMake script invocation in isolation, because Windows
