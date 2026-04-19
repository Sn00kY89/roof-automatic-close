# Roof Automatic Close (FiveM)

A highly optimized, **Standalone** FiveM script that automatically closes convertible roofs and rolls up all windows when a player exits and locks their vehicle.

This script leverages FiveM's modern **State Bags** technology, ensuring perfect visual synchronization across all players in the server without the need for any server-side script (`server.lua`), keeping network traffic to an absolute minimum.

## Features
- 🚗 **Automatic Roof Closing**: When a vehicle is locked, the convertible roof automatically raises via native animation.
- 🪟 **Window Rolling**: All windows are automatically rolled up in sync.
- ⚡ **State Bags Sync**: All nearby clients (even those entering the area later) will correctly see the animation and the vehicle's state, without annoying desync issues.
- 🛠️ **Standalone**: No mandatory dependencies on complex frameworks (ESX, QBCore, etc.). It reads the native lock state (`GetVehicleDoorLockStatus`).
- 🏎️ **Add-On Vehicle Support**: Bypasses the bugged states of some add-on vehicles and forces the correct closing animation for safety.

## Installation
1. Download the code.
2. Place the `roof-automatic-close` folder into your FiveM server's `resources` directory.
3. Add `ensure roof-automatic-close` to your `server.cfg` file.
4. Restart your server or start the resource.

## Requirements
- A FiveM server with moderately recent artifacts to support **State Bags** (any server updated in the last few years is natively supported).
- No framework or database required.

## How It Works
The script cyclically checks if the last driven vehicle has just been locked. Once detected, it applies a unique State Bag to the vehicle. FiveM's engine handles broadcasting this information to all nearby players, triggering the handler (`AddStateBagChangeHandler`) on all listening clients to execute the visual animations locally in perfect sync.

## License
This project is open-source and freely available to use and modify for your server.
