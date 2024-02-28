# Installing

First copy the disko config over

```
scp disko-config.nix nixos@nixos:/tmp/disko-config.nix
```

Then create a file containing your password at /tmp/secret.key

```
echo 'my-password' > /tmp/secret.key
```

Next, create the partition table using disko.

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko-config.nix
```

Once complete, generate the config on the machine, telling nix to not generate filesystems.

```
nixos-generate-config --no-filesystems --root /mnt
```

Afterwards, copy both the config over, and the disko config

```
scp configuration.nix root@nixos:/mnt/etc/nixos/configuration.nix
scp disko-config.nix root@nixos:/mnt/etc/nixos/disko-config.nix
```

Finally, you can install nixos and then reboot

```
nixos-install
reboot
```
