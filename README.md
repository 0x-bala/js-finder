# js-finder
JavaScript Vulnerability and Sensitive Info Scanner
This tool scans JavaScript files from a given domain for sensitive information and vulnerabilities.

## Features
- Fetches JavaScript files using `waybackurls`.
- Scans for API keys, passwords, usernames, emails, and other sensitive information.
- Identifies common JavaScript vulnerabilities such as `eval()`, `innerHTML`, and `localStorage`.

## Requirements
- `curl`
- `waybackurls`
- Bash shell

Developer  
              https://www.instagram.com/0x_bala/

## Installation

1. **Clone the repository** (or download the script):
   ```bash
   git clone https://github.com/0x-bala/js-finder.git
   cd js-finder
   chmod +x js-finder.sh
   ./js-finder.sh <domain>
   
2 . Example:
        ./js-finder.sh example.com
          
        

        


