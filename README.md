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
Known viruses: 8646208
Engine version: 0.103.6
Scanned directories: 0
Scanned files: 1
Infected files: 0
Data scanned: 0.20 MB
Data read: 0.03 MB (ratio 6.25:1)
Time: 12.460 sec (0 m 12 s)
Start Date: 2022:12:22 11:28:30
End Date:   2022:12:22 11:28:42
Archive:  main.zip
80704b5a848c87e35814a2dc4d0a30a6cc7bf139
   creating: Villain-main/
   creating: Villain-main/Core/
  inflating: Villain-main/Core/common.py  
   creating: Villain-main/Core/payload_templates/
   creating: Villain-main/Core/payload_templates/linux/
  inflating: Villain-main/Core/payload_templates/linux/http_payload  
  inflating: Villain-main/Core/payload_templates/linux/https_payload  
   creating: Villain-main/Core/payload_templates/windows/
  inflating: Villain-main/Core/payload_templates/windows/disable_ssl_check  
  inflating: Villain-main/Core/payload_templates/windows/http_payload  
  inflating: Villain-main/Core/payload_templates/windows/http_payload_outfile  
  inflating: Villain-main/Core/payload_templates/windows/https_payload  
  inflating: Villain-main/Core/payload_templates/windows/https_payload_outfile  
  inflating: Villain-main/Core/settings.py  
  inflating: Villain-main/Core/villain_core.py  
  inflating: Villain-main/LICENSE.md  
  inflating: Villain-main/README.md  
  inflating: Villain-main/Usage_Guide.md  
  inflating: Villain-main/Villain.py  
  inflating: Villain-main/requirements.txt  
✔ The package main has been extracted.
```
