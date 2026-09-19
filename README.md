# NanoMC

**Portable Minecraft 1.8.9 launcher**

NanoMC is a small, self-contained launcher layout for Minecraft 1.8.9. Game data, libraries and a bundled Windows Java runtime live inside the project folder.

> **Status:** Experimental / legacy project. The repository is not actively maintained.

## Features
- Portable Minecraft 1.8.9 setup
- Bundled Java runtime for Windows
- Forge 1.8.9 launch path
- Worlds, resource packs and settings stay inside `mcdata/`
- Windows launcher uses paths relative to the launcher
- Linux launcher uses system Java
- Automatic classpath generation from bundled libraries

## Requirements

### Windows
- Windows 10 or newer recommended
- At least 3 GB RAM
- Around 500 MB free disk space
- No separate Java installation required

### Linux
- Compatible Java runtime available as `java`
- Linux-native libraries included in `mcdata/`

## Usage

### Windows
1. Download and extract the repository.
2. Keep the folder structure intact.
3. Run `OpenMC.bat`.
4. Enter a username.
5. Minecraft starts using `mcdata/java/`.

### Linux
```bash
chmod +x OpenMC.sh
./OpenMC.sh
```

To choose another Java executable:
```bash
JAVA_BIN=/path/to/java ./OpenMC.sh
```

## Project layout
```text
NanoMC/
├── OpenMC.bat
├── OpenMC.sh
├── README.md
├── LICENSE
└── mcdata/
    ├── assets/
    ├── config/
    ├── libraries/
    ├── mods/
    ├── natives/
    ├── resourcepacks/
    ├── versions/
    └── java/
```

## Launcher improvements
The launchers no longer maintain a huge hard-coded classpath. They discover JARs under `mcdata/libraries/` at runtime, so adding or replacing a library does not require editing the launcher.

The Windows launcher also resolves `mcdata` relative to `OpenMC.bat`, making shortcuts and USB use more reliable.

## Legal / distribution
NanoMC is not an official Minecraft launcher and is not affiliated with Mojang or Microsoft. Minecraft, Forge, Java and other bundled components have their own licenses and distribution terms. Check those terms before redistributing the complete package.

The project itself is released under the MIT License where applicable.
