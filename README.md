# What's all this, then?

A personal time saver.

---

# TODO

- [ ] Add some code documentation to justfile
- [ ] Generalise template so it's (at least mostly) language-agnostic?
- [ ] Write something to gather upp TODOs from sources into one place

## justfile(s?)

- [ ] config import: file should probably be templated and moved into build tree, like the build justfile
- [ ] Clean up unused vars
- [ ] Proper fzf guards
- [x] Make sure cmake only backs up "raw" justfile if it doesn't already exist (or it will be overwritten by the configured one)

## Windows slowdowns
_Later - switching back to Git bash under Win will do for now._

Doesn't seem to be the files at issue. To check:
 - Is some back-asswards Windows convention spawning new shells?
 - Do I not propagate the set shell?
 - Time a CMake script invocation in isolation, because Windows
 - Try putting Windows logic into a separate pwsh-script and calling that from just
