#!/bin/bash

echo "[+] Разрешаю SSH (TCP 22) с внешнего интерфейса enp1s0..."

# Удаляем дропы, если есть
nft delete rule inet filter input iifname "enp1s0" tcp dport 22 drop 2>/dev/null
nft delete rule inet filter input iifname "enp1s0" drop 2>/dev/null

# Разрешаем новые соединения SSH
nft add rule inet filter input iifname "enp1s0" tcp dport 22 ct state new,established accept

# Убеждаемся, что возвратный трафик тоже разрешён
nft add rule inet filter input ct state established,related accept

echo "[+] Доступ по SSH из интернета ОТКРЫТ"
