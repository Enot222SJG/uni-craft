#!/bin/bash

echo "Uni-Craft - Установка Minecraft"
echo ""

# Проверка flatpak
if ! command -v flatpak &> /dev/null; then
    echo "Ошибка: Flatpak не найден!"
    exit 1
fi

echo "Выберите действие:"
echo "1) Скачать и установить TL Legacy"
echo "2) Установить из локального файла (tl.flatpakref)"
echo ""
read -p "> " action

echo ""
echo "Выберите тип устройства:"
echo "1) kiosk"
echo "2) pc"
echo ""
read -p "> " device_type

if [ "$action" == "1" ]; then
    echo ""
    echo "Скачивание TL Legacy..."
    wget -O tl.flatpakref https://dl.flathub.org/repo/appstream/ch.tlaun.TL.flatpakref

    if [ $? -ne 0 ]; then
        echo ""
        echo "Ошибка при скачивании!"
        exit 1
    fi
elif [ "$action" == "2" ]; then
    if [ ! -f "tl.flatpakref" ]; then
        echo ""
        echo "Файл tl.flatpakref не найден в текущей папке!"
        exit 1
    fi
    echo ""
    echo "Установка из локального файла..."
else
    echo ""
    echo "Неверный выбор!"
    exit 1
fi

# Устанавливаем
echo ""
echo "Установка TL Legacy..."
flatpak install --user tl.flatpakref -y

if [ $? -ne 0 ]; then
    echo ""
    echo "Ошибка при установке!"
    exit 1
fi

# Включаем офлайн режим
echo ""
echo "Настройка офлайн режима..."
flatpak --user override ch.tlaun.TL --env=TL_BOOTSTRAP_OPTIONS="-Dtl.useForce"

echo ""
echo "Готово!"
echo ""
echo "Запустить игру: flatpak run ch.tlaun.TL"
echo ""
