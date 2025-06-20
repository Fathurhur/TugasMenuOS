#!/bin/bash

# Warna
hijau='\e[32m'
kuning='\e[33m'
biru='\e[34m'
merah='\e[31m'
ungu='\e[35m'
reset='\e[0m'

while true; do
    clear
    echo -e "${merah}"
    figlet -w 200 "KERAJAAN KING FATUR"
    echo -e "${reset}"

    echo -e "${biru}=============================================="
    echo -e "            SELAMAT DATANG "
    echo -e "==============================================${reset}"
    echo -e "${kuning}1. Tampilkan Kehidupan Saat Ini${reset}"
    echo -e "${kuning}2. Informasi Jaringan${reset}"
    echo -e "${kuning}3. Tampilkan Detail OS${reset}"
    echo -e "${kuning}4. Tampilkan Waktu Install Pertama OS${reset}"
    echo -e "${kuning}5. Informasi User${reset}"
    echo -e "${merah}6. Keluar${reset}"
    echo "=============================================="

    read -p "Pilih opsi [1-6]: " pilihan
    clear

    case $pilihan in
        1)
            echo -e "${kuning}Proses sedang berjalan: [############################]${reset}"
            sleep 1
            echo
            echo -e "${hijau}Halooo $USER! Tanggal dan Waktu Saat Ini:${reset}"
            date +"%a %b %d %T WIB %Y"
            echo
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;

        2)
            echo -e "${hijau}>> Informasi Jaringan:${reset}"
            ip_local=$(hostname -I | awk '{print $1}')
            gateway=$(ip route | grep default | awk '{print $3}')
            netmask=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')
            dns=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | head -1)

            echo -e "\nInformasi Jaringan:"
            echo -e "Alamat IP Lokal : \e[1;37m$ip_local\e[0m"
            echo -e "Gateway         : \e[32m$gateway\e[0m"
            echo -e "Netmask         : \e[33m$netmask\e[0m"
            echo -e "DNS Server(s)   : \e[36m$dns\e[0m"

            echo -e "\nStatus Koneksi ke Internet:"
            if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
                echo -e "\e[32mTersambung ke Internet.\e[0m"
            else
                echo -e "\e[31mTidak tersambung ke Internet.\e[0m"
            fi

            echo -e "\nStatus Koneksi LAN/WIFI:"
            nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev status

            echo -e "\nLokasi IP (via ipinfo.io):"
            if command -v curl &> /dev/null; then
                CITY=$(curl -s ipinfo.io/city)
                REGION=$(curl -s ipinfo.io/region)
                COUNTRY=$(curl -s ipinfo.io/country)
                if [ -n "$CITY" ] && [ -n "$REGION" ]; then
                    echo -e "${ungu}$CITY, $REGION, $COUNTRY${reset}"
                else
                    echo -e "${merah}Gagal mengambil data lokasi. Periksa koneksi internet Anda.${reset}"
                fi
            else
                echo -e "${merah}Perintah 'curl' tidak ditemukan. Install dengan: sudo apt install curl${reset}"
            fi

            echo
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;

        3)
            echo -e "${hijau}>> Detail OS:${reset}"
            hostnamectl
            echo
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;

        4)
            echo -e "${hijau}>> Waktu Install Pertama OS:${reset}"
            sudo tune2fs -l $(df / | tail -1 | awk '{print $1}') | grep 'Filesystem created'
            echo
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;

        5)
            echo -e "${hijau}>> Informasi User:${reset}"
            echo "Username      : $USER"
            echo "Home Directory: $HOME"
            echo "Shell         : $SHELL"
            echo "Groups        : $(groups)"
            echo
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;

        6)
            echo -e "${merah}Terima kasih telah Datang di kerajaan king fatur!${reset}"
            break
            ;;

        *)
            echo -e "${merah}Pilihan tidak valid. Coba lagi.${reset}"
            read -p "Tekan Enter untuk kembali ke menu..."
            ;;
    esac
done

