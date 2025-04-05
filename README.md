## LCGG

Tired of the Makefile hell? Exhausted by endless, convoluted compilation commands? LCGG is a lightweight terminal tool that simplifies C project management, automating builds and dependencies so you can focus on coding, not configuring.

## Installation Instructions

To install, run the following command:

```bash
curl -sSL https://raw.githubusercontent.com/LuisGrigore/lcgg/main/install.sh | bash
```

---

## 📖 Usage

To use the tool, run:

```bash
lcgg -[COMMAND]
```

### Available Commands:

- **-build**                Builds the project (.o and executables).
- **-init**                 Initializes the current directory as an lcgg project.
- **-update-structure**     Updates all directories that should mirror `src`.
- **-test**                 Compiles and runs tests in the `test` folder.
- **-update**               Updates the lcgg tool to the latest version.
- **-uninstall**            Uninstalls the lcgg tool.
- **-help**                 Displays this help message.
