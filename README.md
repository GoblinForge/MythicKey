# MythicKey

**MythicKey** is a World of Warcraft addon designed to enhance the **Mythic+ dungeon experience**. The addon focuses on automating key mechanics and improving dungeon coordination through optimized features. Future expansions will include integration with **GobLib**, providing advanced API functionalities such as the **Mythic+ Key Announcer**.

## Features

The core reasons for developing **MythicKey** were:

- **🔑 Automatic Keystone Insertion**: Optimized for performance and stability, this feature detects and inserts your Mythic+ Keystone automatically when opening the Mythic+ UI, ensuring minimal impact on game performance and avoiding Lua errors.

- **✅ Ready Check System**: Initiates a ready check as soon as the keystone is inserted to ensure all party members are prepared.

- **⏳ Pre-Pull Countdown** *(Planned Feature)*: After the ready check, a short countdown will notify the group before the dungeon starts, allowing Demon Hunters and others to prepare.

- **📢 Mythic+ Key Announcer** *(Planned Feature as part of GobLib API)*: Announces your Mythic+ key to the group chat automatically when acquired, when a dungeon is completed, and when accepting a Mythic+ key from LFG for reference. This feature can be toggled on/off and will post only the key received from the leader (key host) to reduce unnecessary spam.

- **⏳ Mythic+ Timer (Planned Feature): Provides an in-game timer to help players track and optimize their Mythic+ dungeon run**.

* **⚙️ Customization & Debugging** *(Planned)*: Features will be moved to the new **GobLib** library, allowing modular settings and debugging options.

## Installation

1. Download the latest release of the addon from the [Releases](link-to-releases) page.
2. Extract the ZIP file.
3. Move the extracted folder to `World of Warcraft\Interface\AddOns`.

## Usage

Once installed, **MythicKey** will activate automatically when you open the **Mythic+ UI**.

- Your **Keystone** will be inserted without manual interaction.
- A **Ready Check** will start to confirm your group is prepared.
- *(More features will be added in future updates!)*

## Contributions & Support

We welcome feedback, bug reports, and contributions! If you encounter issues or have ideas for improvement:

- Open an issue on the [Issues](link-to-issues) page.
- Fork the repository and submit a pull request with your changes.

## Development Vision

The idea for **MythicKey** originated during *Legion*. While similar concepts may have emerged independently, this addon was designed from the ground up with a focus on **performance optimization** and **expandability**. Unlike WeakAuras, which can be challenging to maintain and extend, **MythicKey** is built to be both lightweight and adaptable, reducing performance overhead while avoiding Lua errors.

## Disclaimer

This addon was independently developed, and while similar ideas may exist, **MythicKey** was designed from the ground up with a focus on performance efficiency and stability. The **Mythic+ Key Announcer** feature was inspired by [runningbird’s Mythic-Plus-Key-Announcer](https://github.com/runningbird/Mythic-Plus-Key-Announcer), but **MythicKey** is a standalone project with no direct affiliation or endorsement from runningbird or **HydraAddons**, the creator of [AutoKeystone](https://www.curseforge.com/wow/addons/autokeystone). Unlike standalone announcers, **MythicKey** integrates multiple M+ functionalities into a single addon, reducing the need for multiple separate addons. Additionally, this feature enhances the **Automatic Keystone Insertion** by integrating a **Ready Check System**, ensuring the group is prepared immediately after the keystone is placed.



## License

**MythicKey** is released under the [MIT License](link-to-license).

