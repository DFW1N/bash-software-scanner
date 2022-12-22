# Package Downloader and Scanner

This script is a simple tool that allows you to download a package from a URL, scan it for malware using ClamAV, and extract it.

---

## Features

- Support for multiple file extensions: `tar.gz`, `zip`, `bz2`, `xz`, `rar`, `exe`.
- Support for multiple operating systems: macOS, Linux (Debian-based and Red Hat-based).
- Automatic installation of ClamAV and Wine if they are not already installed.
- Automatic installation of unzip and unrar if they are not already installed.
- Verbose output of the ClamAV scan.
- Colorful and intuitive output messages with icons.
- Error handling for missing package URL and unsupported file extensions.

---

## Usage

To use the script, simply provide the URL of the package as the first command line argument:

```bash
./software-scanner.sh https://example.com/package.tar.gz
```

---

## Examples

Here are some examples of valid package URLs:

    https://example.com/package.tar.gz
    https://example.com/package.zip
    https://example.com/package.bz2
    https://example.com/package.xz
    https://example.com/package.rar
    https://example.com/package.exe
    file:///path/to/local/package-2.0.tar.bz2
    ftp://ftp.example.com/package-1.1.zip

---

## Requirements

    Bash shell
    cURL
    ClamAV (installed automatically if not present)
    Wine (installed automatically if not present for .exe files)
    unzip (installed automatically if not present for .zip files)
    unrar (installed automatically if not present for .rar files)

---

## Output Example

Example of an output that has been scanned and ClamAV has not found any viruses or threats in.

```bash
----------- SCAN SUMMARY -----------
Archive:  main.zip
80704b5a848c87e35814a2dc4d0a30a6cc7bf139
   creating: /tmp/package/Villain-main/
   creating: /tmp/package/Villain-main/Core/
  inflating: /tmp/package/Villain-main/Core/common.py  
   creating: /tmp/package/Villain-main/Core/payload_templates/
   creating: /tmp/package/Villain-main/Core/payload_templates/linux/
  inflating: /tmp/package/Villain-main/Core/payload_templates/linux/http_payload  
  inflating: /tmp/package/Villain-main/Core/payload_templates/linux/https_payload  
   creating: /tmp/package/Villain-main/Core/payload_templates/windows/
  inflating: /tmp/package/Villain-main/Core/payload_templates/windows/disable_ssl_check  
  inflating: /tmp/package/Villain-main/Core/payload_templates/windows/http_payload  
  inflating: /tmp/package/Villain-main/Core/payload_templates/windows/http_payload_outfile  
  inflating: /tmp/package/Villain-main/Core/payload_templates/windows/https_payload  
  inflating: /tmp/package/Villain-main/Core/payload_templates/windows/https_payload_outfile  
  inflating: /tmp/package/Villain-main/Core/settings.py  
  inflating: /tmp/package/Villain-main/Core/villain_core.py  
  inflating: /tmp/package/Villain-main/LICENSE.md  
  inflating: /tmp/package/Villain-main/README.md  
  inflating: /tmp/package/Villain-main/Usage_Guide.md  
  inflating: /tmp/package/Villain-main/Villain.py  
  inflating: /tmp/package/Villain-main/requirements.txt  

----------- SCAN SUMMARY -----------
Known viruses: 8646208
Engine version: 0.103.6
Scanned directories: 6
Scanned files: 15
Infected files: 0
Data scanned: 0.16 MB
Data read: 0.09 MB (ratio 1.91:1)
Time: 11.216 sec (0 m 11 s)
Start Date: 2022:12:22 13:01:10
End Date:   2022:12:22 13:01:21
[✔] No threats detected in main.zip
[✔] Deleting temporary directoy package
[✔] The package main has been extracted.
```
