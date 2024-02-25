#!/bin/bash

# Function for base64 encoding
base64_encode() {
    read -p "Enter the string to encode: " string_to_encode
    encoded_string=$(echo -n "$string_to_encode" | base64)
    echo "Base64 encoded string: $encoded_string"
}

# Function for base64 decoding
base64_decode() {
    read -p "Enter the base64 encoded string: " encoded_string
    decoded_string=$(echo "$encoded_string" | base64 -d)
    echo "Decoded string: $decoded_string"
}

# Function for URL encoding
url_encode() {
    read -p "Enter the string to URL encode: " string_to_encode
    encoded_string=$(echo -n "$string_to_encode" | xxd -plain | tr -d '\n' | sed 's/\(..\)/%\1/g')
    echo "URL encoded string: $encoded_string"
}

# Function for URL decoding
url_decode() {
    read -p "Enter the URL encoded string: " encoded_string
    decoded_string=$(echo -n "$encoded_string" | sed 's/+/ /g;s/%\(..\)/\\x\1/g' | xargs -0 printf "%b")
    echo "Decoded string: $decoded_string"
}

# Function for HTML encoding
html_encode() {
    read -p "Enter the string to HTML encode: " string_to_encode
    encoded_string=$(echo -n "$string_to_encode" | python3 -c "import html, sys; print(html.escape(sys.stdin.read().strip()))")
    echo "HTML encoded string: $encoded_string"
}

# Function for HTML decoding
html_decode() {
    read -p "Enter the HTML encoded string: " encoded_string
    decoded_string=$(echo -n "$encoded_string" | python3 -c "import html, sys; print(html.unescape(sys.stdin.read().strip()))")
    echo "Decoded string: $decoded_string"
}

Main(){
cd .. && bash Main.sh
}
# Main Menu
while true; do
    echo "Select an option:"
    echo "1. Base64 Encode"
    echo "2. Base64 Decode"
    echo "3. URL Encode"
    echo "4. URL Decode"
    echo "5. HTML Encode"
    echo "6. HTML Decode"
    echo "7. Main Menu"
    echo "8. Exit"
    read -p "Enter your choice: " choice
    case $choice in
        1) base64_encode;;
        2) base64_decode;;
        3) url_encode;;
        4) url_decode;;
        5) html_encode;;
        6) html_decode;;
        7) Main;;
        8) echo "Exiting..."; exit;;
        *) echo "Invalid choice. Please enter a number between 1 and 8.";;
    esac
done
