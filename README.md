# Zephyr-Android

B4A (Basic4Android) test app that talks to a Zephyr Bluetooth heart-rate / fitness device over serial. It decodes packets for heart rate, distance, speed, strides, firmware/hardware ids, and battery, and shows them on a portrait full-screen UI (`Zeph Test`, package `canalrun.apps.zephtest`). Project file is B4A 3.5; module `ChatActivity` is named but was not in the archive. For bench-testing Zephyr HxM-style sensors.

**Language:** B4A  
**Target:** Android (B4A 3.5, minSdk 4, portrait)  
**Output:** Android application

## Solution structure

| Project | Language | Type | Purpose |
|---------|----------|------|---------|
| `ZephTst` | B4A | Android app | Bluetooth serial test UI for Zephyr HxM-style packets |
| `MyUtils.bas` | B4A | module | Shared helpers |
| `HdgLabel.bas` | B4A | custom view | Heading label |
| `GrdLabel.bas` | B4A | custom view | Grid label |
| `Files/Tst.bal` | B4A | layout | Main layout |

## How to open

Open `ZephTst.b4a` in the B4A IDE.

## Attribution and provenance

Imported from `B4A-Projects.zip` (folder `Zephyr Android`). No keystores were included. Package `canalrun.apps.zephtest` / application label Zeph Test. Dave Robinson / VaderConsulting historical working copy.

## License

MIT © 2026 VaderConsulting for Dave's code. See `LICENSE`.
