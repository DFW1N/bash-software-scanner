#!/bin/bash

# Author: Sacha Roussakis-Notter

# Script banner
echo ""
echo -e "\e[1;33m#########################################\e[0m"
echo -e "\e[1;33m# \e[1;32mPackage Downloader and Scanner\e[1;33m        #\e[0m"
echo -e "\e[1;33m# \e[1;32mAuthor: \e[1;34mSacha Roussakis-Notter\e[1;33m        #\e[0m"
echo -e "\e[1;33m#########################################\e[0m"
echo ""

# $1 is the first command line argument passed to the script, which is the name of the package to be installed
package_url=$1

# Check if the package URL is set
if [[ -z "$package_url" ]]; then
  # The package URL is not set, print an error message with a red cross icon
  echo -e "\033[31m✖\033[0m Error: The package URL is not set.

Examples of package URLs:
- https://example.com/package-1.0.tar.gz
- ftp://ftp.example.com/package-1.1.zip
- file:///path/to/local/package-2.0.tar.bz2"
  exit 1
fi

# Determine the operating system type
os=$(uname -s)

# Check if ClamAV is installed
if ! command -v clamscan >/dev/null 2>&1; then
  # If ClamAV is not installed, install it
  if [[ "$os" == "Darwin" ]]; then
    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
      # If Homebrew is not installed, install it
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # Install ClamAV using Homebrew
    brew install clamav
  elif [[ "$os" == "Linux" ]]; then
    # Check if the system uses apt-get as the package manager
    if command -v apt-get >/dev/null 2>&1; then
      # Install ClamAV using apt-get
      apt-get update && apt-get install -y clamav
    elif command -v dnf >/dev/null 2>&1; then
      # Install ClamAV using dnf (Fedora)
      dnf install -y clamav
    elif command -v yum >/dev/null 2>&1; then
      # Install ClamAV using yum (CentOS, Red Hat)
      yum install -y clamav
    fi
  fi
fi

# Update the ClamAV virus definitions
freshclam

# Set the download command based on the operating system type
if [[ "$os" == "Darwin" ]]; then
  # macOS uses curl to download files
  download_cmd="curl -L -o"
elif [[ "$os" == "Linux" ]]; then
  # Linux systems can use either wget or curl to download files
  download_cmd="wget -O"
fi

# Extract the package name and file extension from the URL using regex
package_name=$(echo "$package_url" | sed -E 's/.*\/(.*)\.(tar\.gz|zip|bz2|[^.]*)$/\1/')
extension=$(echo "$package_url" | sed -E 's/.*\/(.*)\.(tar\.gz|zip|bz2|[^.]*)$/\2/')

# Download the package
$download_cmd "$package_name.$extension" "$package_url"

# Scan the package for viruses
#clamscan -v "$package_name.$extension"

# Check the exit code of the scan
if [ $? -eq 0 ]; then
  # The scan was successful, extract the package
  if [[ "$extension" == "tar.gz" ]]; then
    mkdir -p /tmp/package
    tar -xzvf "$package_name" -C /tmp/package

    # Scan the extracted files using ClamAV
    clamscan -v -r -i /tmp/package

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name\e[0m"
    fi

    # Clean up the temporary directory
    rm -rf /tmp/package

    tar -xzf "$package_name.$extension"

  elif [[ "$extension" == "zip" ]]; then
    # Check if unzip is installed
    if ! [ -x "$(command -v unzip)" ]; then
      # Unzip is not installed, install it
      if [[ "$os" == "Darwin" ]]; then
        # macOS uses Homebrew as the package manager
        brew install unzip
      elif [[ "$os" == "Linux" ]]; then
        # Check if the system has apt-get package manager
        if [ -x "$(command -v apt-get)" ]; then
          # Debian-based systems use apt-get as the package manager
          apt-get install unzip
        else
          # Red Hat-based systems use yum as the package manager
          yum install unzip
        fi
      fi
    fi
    # Extract the contents of the .zip file into a temporary directory
    mkdir -p /tmp/package
    unzip "$package_name.$extension" -d /tmp/package

    # Scan the extracted files using ClamAV
    clamscan -r -i /tmp/package

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name.$extension\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name.$extension\e[0m"
    fi

    # Clean up the temporary directory
    rm -rf /tmp/package
    echo -e "\e[1;32m[✔] Deleting temporary directoy $package_name.$extension\e[0m"

  elif [[ "$extension" == "bz2" ]]; then
    # Decompress the .bz2 file
    bzip2 -d "$package_name.$extension"

    # Scan the decompressed file using ClamAV
    clamscan -i "$package_name"

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name\e[0m"
    fi

  elif [[ "$extension" == "xz" ]]; then
    # Decompress the .xz file
    xz -d "$package_name.$extension"

    # Scan the decompressed file using ClamAV
    clamscan -i "$package_name"

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name\e[0m"
    fi

  elif [[ "$extension" == "rar" ]]; then
   # Check if unrar is installed
    if ! [ -x "$(command -v unrar)" ]; then
      # Unrar is not installed, install it
      if [[ "$os" == "Darwin" ]]; then
        # macOS uses Homebrew as the package manager
        brew install unrar
      elif [[ "$os" == "Linux" ]]; then
        # Check if the system has apt-get package manager
        if [ -x "$(command -v apt-get)" ]; then
          # Debian-based systems use apt-get as the package manager
          apt-get install unrar
        else
          # Red Hat-based systems use yum as the package manager
          yum install unrar
        fi
      fi
    fi
    # Extract the contents of the .rar file
    mkdir "$package_name"
    unrar x "$package_name.$extension" "$package_name"

    # Scan the extracted files using ClamAV
    clamscan -r -i "$package_name"

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name\e[0m"
    fi

  elif [[ "$extension" == "exe" ]]; then
    # Check if wine is installed
    if ! [ -x "$(command -v wine)" ]; then
      # Wine is not installed, install it
      if [[ "$os" == "Darwin" ]]; then
        # macOS uses Homebrew as the package manager
        brew install wine
      elif [[ "$os" == "Linux" ]]; then
        # Check if the system has apt-get package manager
        if [ -x "$(command -v apt-get)" ]; then
          # Debian-based systems use apt-get as the package manager
          apt-get install wine
        else
          # Red Hat-based systems use yum as the package manager
          yum install wine
        fi
      fi
    fi
    # Extract the package using wine
    wine "$package_name.$extension"

    # Scan the .exe file using ClamAV
    clamscan -i "$package_name.$extension"

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name.$extension\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name.$extension\e[0m"
    fi
  else
    # Scan the file using ClamAV
    clamscan -v -i "$package_name.$extension"

    # Check the exit code of the scan
    if [ $? -eq 0 ]; then
        # No threats detected
        echo -e "\e[1;32m[✔] No threats detected in $package_name.$extension\e[0m"
    else
        # Threats detected
        echo -e "\e[1;31m[✘] Threats detected in $package_name.$extension\e[0m"
    fi
    if [ $? -eq 1 ]; then
        # Unsupported file extension, print an error message with a red cross icon
        echo -e "\033[31m✖\033[0m Error: Unsupported file extension '$extension'."
        exit 1
    fi
  fi
  # Print a success message with a green checkmark icon
  echo -e "\033[32m[✔]\033[0m The package $package_name has been extracted."
else
  # The scan failed, delete the package
  rm "$package_name.$extension"
  # Print an error message with a red cross icon
  echo -e "\033[31m✖\033[0m The package $package_name has been deleted because it failed the virus scan."
fi
