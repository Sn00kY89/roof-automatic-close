FiveM - Automatic Convertible Roof Closer 🚗🔒

A simple standalone script for FiveM that automatically closes the roof of convertible cars and windows when the vehicle is locked from the outside.

Developed to enhance roleplay immersion, the script natively "listens" to the vehicle's door lock state, making it compatible with any existing key script.

✨ Features

100% Standalone: Does not require ESX, QBCore, or other frameworks. Works out-of-the-box.

Universal Compatibility: Works perfectly with scripts like qb-vehiclekeys, esx_vehiclelock, wasabi_carlock, or any other locking system, as it directly reads GTA V natives.

Modded Cars Fix Included: Many add-on cars do not correctly communicate the convertible roof "state" to the game. This script bypasses the issue by forcing the closing animation to ensure it works on all mods (that use the H key for the roof).

Window Closing: Automatically roll up all windows when locking the car.

Highly Optimized: Performance impact of 0.00ms.

📥 Installation

Download the latest release or clone this repository.

Extract the content into a new folder within your server's resources (e.g., resources/[scripts]/roof-automatic-close).

Ensure the folder contains the fxmanifest.lua and client.lua files.

Open your server.cfg file and add the following line:

ensure roof-automatic-close


Restart the server or start the resource from the server console (start roof-automatic-close).



🐛 Bug Reporting

If you encounter issues with specific cars or have suggestions, feel free to open an Issue on this repository.

📄 License

This project is licensed under the MIT License. You are free to use, modify, and share it!
