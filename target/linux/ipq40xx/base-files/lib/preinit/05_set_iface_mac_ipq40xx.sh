. /lib/functions.sh

preinit_set_mac_address() {
  case $(board_name) in
  asus,map-ac2200)
    base_mac=$(mtd_get_mac_binary_ubi Factory 0x1006)
    ip link set dev eth0 address $(macaddr_add "$base_mac" 1)
    ip link set dev eth1 address $(macaddr_add "$base_mac" 3)
    ;;
  asus,rt-ac42u)
    base_mac=$(mtd_get_mac_binary_ubi Factory 0x1006)
    ip link set dev eth0 address $base_mac
    ip link set dev lan1 address $base_mac
    ip link set dev lan2 address $base_mac
    ip link set dev lan3 address $base_mac
    ip link set dev lan4 address $base_mac
    ip link set dev wan address $(mtd_get_mac_binary_ubi Factory 0x9006)
    ;;
  engenius,eap2200)
    base_mac=$(cat /sys/class/net/eth0/address)
    ip link set dev eth1 address $(macaddr_add "$base_mac" 1)
    ;;
  extreme-networks,ws-ap3915i | \
    extreme-networks,ws-ap391x)
    ip link set dev eth0 address $(mtd_get_mac_ascii CFG1 ethaddr)
    ;;
  linksys,ea8300 | \
    linksys,mr8300)
    base_mac=$(mtd_get_mac_ascii devinfo hw_mac_addr)
    ip link set dev lan1 address $(macaddr_add "$base_mac" 1)
    ip link set dev eth0 address $(macaddr_setbit "$base_mac" 7)
    ;;
  linksys,whw03)
    base_mac=$(mmc_get_mac_ascii devinfo hw_mac_addr)
    ip link set dev eth0 address "$base_mac"
    ip link set dev lan address "$base_mac"
    ip link set dev wan address "$base_mac"
    ;;
  mikrotik,wap-ac | \
    mikrotik,wap-ac-lte | \
    mikrotik,wap-r-ac)
    base_mac=$(cat /sys/firmware/mikrotik/hard_config/mac_base)
    ip link set dev sw-eth1 address "$base_mac"
    ip link set dev sw-eth2 address $(macaddr_add "$base_mac" 1)
    ;;
  teltonika,rutx50)
    # Vendor Bootloader removes nvmem-cells from partition,
    # so this needs to be done here.
    base_mac="$(mtd_get_mac_binary 0:CONFIG 0x0)"
    ip link set dev eth0 address "$base_mac"
    ip link set dev lan1 address "$base_mac"
    ip link set dev lan2 address "$base_mac"
    ip link set dev lan3 address "$base_mac"
    ip link set dev lan4 address "$base_mac"
    ip link set dev wan address "$(macaddr_add "$base_mac" 1)"
    ;;
  tplink,deco-m4r-v3)
    # Set MAC addresses for interfaces based on ART partition
    # Validated against stock firmware MAC assignment scheme

    BASE_MAC=$(mtd_get_mac_binary art 0x0 2>/dev/null)

    if [ -n "$BASE_MAC" ] && [ "$BASE_MAC" != "00:00:00:00:00:00" ]; then
      # Interface MAC assignment validated from stock firmware:
      # LAN: Base MAC (swport4)
      # WAN: Base MAC + 1 (swport5)
      # WiFi 2.4G: Base MAC + 2 (radio0)
      # WiFi 5G: Base MAC + 3 (radio1)

      # Set DSA switch port MAC addresses
      ip link set dev lan address "$BASE_MAC" 2>/dev/null
      ip link set dev wan address "$(macaddr_add $BASE_MAC 1)" 2>/dev/null

      # Set WiFi interface MAC addresses (when interfaces exist)
      [ -d /sys/class/net/wlan0 ] && ip link set dev wlan0 address "$(macaddr_add $BASE_MAC 2)" 2>/dev/null
      [ -d /sys/class/net/wlan1 ] && ip link set dev wlan1 address "$(macaddr_add $BASE_MAC 3)" 2>/dev/null

      logger -t mac_config "MAC addresses configured from ART: $BASE_MAC"
    else
      logger -t mac_config "Warning: Could not read MAC from ART partition"
    fi
    ;;
  zyxel,nbg6617)
    base_mac=$(cat /sys/class/net/eth0/address)
    ip link set dev eth0 address $(macaddr_add "$base_mac" 2)
    ip link set dev eth1 address $(macaddr_add "$base_mac" 3)
    ;;
  esac
}

boot_hook_add preinit_main preinit_set_mac_address
