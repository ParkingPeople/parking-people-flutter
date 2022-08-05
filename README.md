# ParkingPeople flutter app

`flutter` can be replaced with `fvm flutter` if using fvm

## Build

Generate sources

`flutter pub run build_runner watch --delete-conflicting-outputs [--use-polling-watcher]`

Build for android

`flutter build apk --release --obfuscate --split-debug-info=symbols/`

## Run

Remove previous installations(when stuck with installing)

`adb uninstall <package name>`

Run

`flutter run`
