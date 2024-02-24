#!/bin/bash
cat logo.txt | lolcat -a -s 1090
# Display the menu
echo "Menu:"
echo "1. Information Gathering"
echo "2. Vulnerability Assessment"
echo "3. Generate Report"
echo "4. AI Bot"
echo "5. Encoder"
echo "6. About Us"

# Read user input
read -p "Choose an option: " option

# Execute the corresponding file based on user input
case $option in
    1) bash info/new1.sh ;;
    2) ./vulnerability.sh ;;
    3) ./report.sh ;;
    4) ./ai_bot.sh ;;
    5) ./encoder.sh ;;
    6) ./about_us.sh ;;
    *) echo "Invalid option. Please choose a valid option." ;;
esac
