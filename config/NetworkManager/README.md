# `README`

## Editing connections

The connections lies in: `/etc/NetworkManager/system-connections/*.nmconnection`

### Hiding machine `hostname`

Add these lines to the preceding connections

```txt
[ipv4]
dhcp-send-hostname=false

[ipv6]
dhcp-send-hostname=false
```

## Configuring MAC address randomization

- <https://wiki.archlinux.org/title/NetworkManager>
- `/etc/NetworkManager/conf.d/`

## Icons

- Some icons are in: `/usr/share/icons/hicolor/scalable/apps`
- Others are in: `/usr/share/icons/hicolor/22x22/apps`
