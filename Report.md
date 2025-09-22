# Feature 2 – Multi-file Project Report

## Q1. Explain the linking rule in this part's Makefile:


**Answer:**  
This rule is the *linking step* of the build process.  
- `$(TARGET)` (our final executable `bin/client`) depends on `$(OBJECTS)` (all compiled `.o` files).  
- When all the `.o` files are ready, the compiler (`gcc`) links them together into a single binary.  
- `$@` refers to the target (the executable), and `$^` would refer to all prerequisites (the object files).  
In short: this rule takes all compiled object files and links them into the final program.

---

## Q2. What are git tags, and how are they useful?

**Answer:**  
A **git tag** is a pointer to a specific commit that marks it as important (e.g., a release point).  
Tags are often used for:  
- Marking **version numbers** (e.g., `v0.1.1-multifile`).  
- Making it easy to reference stable states of the codebase.  
- Ensuring developers can always return to that exact version.  
Unlike branches, tags don’t move — they are fixed markers in the repository’s history.

---

## Q3. What are GitHub releases, and how are they useful?

**Answer:**  
A **GitHub Release** is a packaged version of the codebase tied to a tag.  
Releases are useful because they:  
- Provide a **downloadable binary/executable** (`bin/client` in this case) so users don’t need to build from source.  
- Serve as official **distribution points** for stable versions.  
- Can include **release notes**, explaining changes since the last version.  
- Allow users to quickly get either the **source code (zip/tar.gz)** or the **compiled program**.  

In this project, the release contains the compiled `bin/client` executable so anyone can run the program directly.

---
