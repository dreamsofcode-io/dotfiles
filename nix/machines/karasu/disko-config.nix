{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "4G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "luks_lvm";
                passwordFile = "/tmp/secret.key";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "nix";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      nix = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "66G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          main = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "noatime" ];
                }
              };
            };
          };
        };
      };
    };
  };
}
