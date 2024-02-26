#!/bin/bash
clear
cat info/logo.txt | lolcat -a -s 1090
# Function to display menu
display_menu() {
    echo "Vulnerability Assessment Tool"
    echo "1. DNS Information"
    echo "2. Whois Information"
    echo "3. Open Port Scanner"
    echo "4. Web Scraping Tool"
    echo "5. Technologies Used By website"
    echo "6. Directory and Endpoint Fuzzing"
    echo "7. Subdomain Finder"
    echo "8. Run All Options"
    echo "9. Main Menu"
    echo "10. Exit"
}

# Function to ask for URL
ask_for_url() {
    read -p "Enter URL: " url
    website_folder=$(echo $url | sed 's/[^a-zA-Z0-9]/_/g')
}

# Function to create website folder
create_website_folder() {
    if [ ! -d "$website_folder" ]; then
        mkdir "$website_folder"
        echo "Website folder created: $website_folder"
    else
        echo "Website folder already exists: $website_folder"
    fi
}

# Function for DNS Information
dns_information() {
    echo "DNS Information for $url:"
    nslookup $url | tee "$website_folder/dns_info.txt"
}

# Function for Whois Information
whois_information() {
    echo "Whois Information for $url:"
    whois $url | tee "$website_folder/whois_info.txt"
}

# Function for Open Port Scanner
open_port_scanner() {
    echo "Scanning open ports for $url:"
    nmap -v $url | tee "$website_folder/open_ports.txt"
}

# Function for Web Scraping Tool
web_scraping_tool() {
    echo "Scraping $url:"
    # Example custom web scraping script
    # This is a placeholder, you can replace it with your own custom script
    python WebScrapper.py https://$url | tee "$website_folder/web_scraping_output.txt"
    #gau $url | tee "$website_folder/web_scraping_output.txt"
}

# Function for Alternative of Wappalyzer CLI
Technologies_Used_By_website() {
    echo "Alternative of Wappalyzer CLI for $url:"
    # Example using whatweb
    whatweb $url | tee "$website_folder/wappalyzer_alternative_output.txt"
}

# Function for Directory and Endpoint Fuzzing
directory_endpoint_fuzzing() {
    echo "Fuzzing directories and endpoints for $url with status codes 200, 403, 500:"
    # Example using wfuzz with specific status codes
    gobuster dir -u https://$url -w /usr/share/wordlists/dirb/common.txt | tee "$website_folder/fuzzing_output.txt"
}

# Function for Subdomain Finder
subdomain_finder() {
    echo "Finding subdomains for $url:"
    # Example using subfinder
    subfinder -d $url | tee "$website_folder/subdomains.txt"
}

# Function to run all options and save output to all.txt
run_all_options() {
    echo "Running all options and saving output to all.txt"
    dns_information
    whois_information
    open_port_scanner
    web_scraping_tool
    Technologies_Used_By_website
    directory_endpoint_fuzzing
    subdomain_finder
    cat "$website_folder"/*.txt > "$website_folder/all.txt"
    echo "All outputs saved to $website_folder/all.txt"
}

# Main script
ask_for_url
create_website_folder

while true; do
    display_menu
    read -p "Enter your choice (1-10): " choice
    case $choice in
        1) dns_information ;;
        2) whois_information ;;
        3) open_port_scanner ;;
        4) web_scraping_tool ;;
        5) Technologies_Used_By_website ;;
        6) directory_endpoint_fuzzing ;;
        7) subdomain_finder ;;
        8) run_all_options ;;
        9) 
            #echo "Returning to Main Menu..."
             bash Main.sh
            break ;;
           
        10) 
            echo "Exiting..."
            break ;;
        *) 
            echo "Invalid choice. Please enter a number between 1 and 10." ;;
    esac
done


