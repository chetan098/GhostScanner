#!/bin/bash

# Information Gathering Script

# Function to display menu
display_menu() {
  echo "Choose an option:"
  echo "1. Dnsenum"
  echo "2. Dnsrecon"
  echo "3. Whois"
  echo "4. Custom Nmap"
  echo "5. Theharvester"
  echo "6. Sherlock"
  echo "7. Web Scraper"
  echo "8. Wappalyzer"
  echo "9. Gobuster"
  echo "10. Dirb"
  echo "11. Subfinder"
  echo "0. Exit"
}

# Function to gather information using selected tool
gather_information() {
  local choice=$1

  case $choice in
    1)
      echo "Enter the domain for Dnsenum:"
      read domain
      dnsenum $domain
      ;;
    2)
      echo "Enter the domain for Dnsrecon:"
      read domain
      dnsrecon -d $domain
      ;;
    3)
      echo "Enter the domain for Whois:"
      read domain
      whois $domain
      ;;
    4)
      echo "Enter the target for Custom Nmap:"
      read target
      echo "Enter Nmap options:"
      read nmap_options
      nmap $nmap_options $target
      ;;
    5)
      echo "Enter the target for Theharvester:"
      read target
      theharvester -d $target -l 500 -b all
      ;;
    6)
      echo "Enter the username for Sherlock:"
      read username
      python3 sherlock.py $username
      ;;
    7)
      echo "Enter the URL for Web Scraper:"
      read url
      python3 web_scraper.py $url
      ;;
    8)
      echo "Enter the target URL for Wappalyzer:"
      read target_url
      wappalyzer-cli $target_url
      ;;
    9)
      echo "Enter the URL for Gobuster:"
      read url
      gobuster dir -u $url -w /path/to/wordlist.txt
      ;;
    10)
      echo "Enter the URL for Dirb:"
      read url
      dirb $url
      ;;
    11)
      echo "Enter the domain for Subfinder:"
      read domain
      subfinder -d $domain
      ;;
    0)
      echo "Exiting the script."
      exit 0
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Main script

while true; do
  display_menu
  read -p "Enter your choice (0 to exit): " user_choice

  gather_information $user_choice
done
