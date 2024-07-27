# README

- [Arch wiki](https://wiki.archlinux.org/title/Iwd#eduroam)
- [Reddit](https://www.reddit.com/r/archlinux/comments/e6gkac/iwd_and_eduroam/)
- [Reddit](https://www.reddit.com/r/archlinux/comments/2mon17/eduroam_on_arch_linux/)

Create file `eduroam.8021x` in `/var/lib/iwd`

```txt
[Security]
EAP-Method=PEAP
EAP-Identity=anonymous@tu-clausthal.de
EAP-PEAP-CACert=/var/lib/iwd/chain.pem
EAP-PEAP-Phase2-Method=MSCHAPV2
EAP-PEAP-Phase2-Identity=XXXX@tu-clausthal.de
EAP-PEAP-Phase2-Password=XXXXX
EAP-PEAP-ServerDomainMask=*.tu-clausthal.de

[Settings]
Autoconnect=true
```

If needed, download the `python` script from [eduroam.org](https://cat.eduroam.org/) and run to get the output for your university
