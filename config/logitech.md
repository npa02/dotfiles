# Libratbag Guide

`Libratbag` as the replacement tool for G-HUB

Check source: [Libratbag](https://womanonrails.com/logitech-g915-tkl)

## Basic

- Listing connected devices.\
    Sometimes it can only detect one at a time. So in case many are connected, but only one is listed, try to connect and configure one at a time.

    ```bash
    ratbagctl list
    # Output:
    # chanting-squirrel:   Logitech G903 LS
    # warbling-mara:       Logitech G915 TKL LIGHTSPEED Wireless RGB Mechanical Gaming Keyboard
    ```

- See current device info (profile, resolutions, button, lighting, etc.)

    ```bash
    ratbagctl chanting-squirrel info
    ```

- Lighting:

    ```bash
    ratbagctl chanting-squirrel led get
    ratbagctl chanting-squirrel led 0 set mode breathing
    ratbagctl chanting-squirrel led 0 set brightness 140
    ```

## Config

### G915 TKL

```bash
LED: 0, depth: rgb, mode: on, color: ff2626
LED: 1, depth: rgb, mode: on, color: ff2626
```

### G903 LS

```bash
LED: 0, depth: rgb, mode: breathing, color: ff2626, duration: 4700, brightness: 122
LED: 1, depth: rgb, mode: breathing, color: ff2626, duration: 4700, brightness: 122
```
