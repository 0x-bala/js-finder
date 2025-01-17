#!/bin/bash

program_name="\e[1;36mJavaScript Vulnerability and Sensitive Info Scanner\e[0m"
developer_name="\e[1;32m0x-bala\e[0m"
developer_instagram="\e[1;34mhttps://www.instagram.com/0x_bala/\e[0m"
developer_github="\e[1;34mhttps://github.com/0x-bala\e[0m"
print_program_info() {
    echo -e "\n\e[1;35m=====================================================\e[0m"
    echo -e "Program Name: $program_name"
    echo -e "Developer: $developer_name"
    echo -e "Instagram: $developer_instagram"
    echo -e "GitHub: $developer_github"
    echo -e "\e[1;35m=====================================================\e[0m"
}

print_usage_info() {
    echo -e "\e[1;33mUsage: Scan for JS vulnerabilities.\e[0m"
}

fetch_js_files() {
    local domain=$1
    local output_file=$2
    echo -e "\e[1;32mFetching JavaScript files for $domain using waybackurls...\e[0m"
    echo $domain | waybackurls | grep '\.js$' > $output_file
}

scan_for_sensitive_info() {
    local js_url=$1
    echo -e "\e[1;33mScanning $js_url for sensitive information...\e[0m"
    curl -s $js_url | grep -Eo '(api[_-]?key["'\''"]?\s*[:=]\s*["'\''"]?[\w-]+["'\''"]?|password["'\''"]?\s*[:=]\s*["'\''"]?[^"'\''"]+["'\''"]?|username["'\''"]?\s*[:=]\s*["'\''"]?[^"'\''"]+["'\''"]?|email["'\''"]?\s*[:=]\s*["'\''"]?[^"'\''"]+["'\''"]?|token["'\''"]?\s*[:=]\s*["'\''"]?[\w-]+["'\''"]?|secret["'\''"]?\s*[:=]\s*["'\''"]?[^"'\''"]+["'\''"]?)' | while read -r line ; do
        echo -e "\e[1;31mSensitive info found in $js_url: $line\e[0m"
        echo "Sensitive info found in $js_url: $line" >> sensitive_info.txt
    done
}

# Function to scan JavaScript files for vulnerabilities
scan_for_vulnerabilities() {
    local js_url=$1
    echo -e "\e[1;33mScanning $js_url for vulnerabilities...\e[0m"
    curl -s $js_url | grep -Eo '(eval\(|document\.write\(|innerHTML|localStorage|sessionStorage|postMessage)' | while read -r line ; do
        echo -e "\e[1;31mVulnerability found in $js_url: $line\e[0m"
        echo "Vulnerability found in $js_url: $line" >> vulnerabilities.txt
    done
}

main() {
    if [ -z "$1" ]; then
        echo -e "\e[1;31mUsage: $0 <domain>\e[0m"
        exit 1
    fi

    local domain=$1
    local output_file="output.txt"
    
    print_program_info
    print_usage_info
        fetch_js_files $domain $output_file

    > sensitive_info.txt
    > vulnerabilities.txt

    while read -r js_file; do
        scan_for_sensitive_info $js_file
        scan_for_vulnerabilities $js_file
    done < $output_file

    echo -e "\e[1;35m=====================================================\e[0m"
    echo -e "\e[1;32mScan completed. Results:\e[0m"
    echo -e "\e[1;34mSensitive Information found:\e[0m"
    cat sensitive_info.txt
    echo -e "\e[1;34m-----------------------------------------------------\e[0m"
    echo -e "\e[1;34mVulnerabilities found:\e[0m"
    cat vulnerabilities.txt
    echo -e "\e[1;35m=====================================================\e[0m"
}

main $1
