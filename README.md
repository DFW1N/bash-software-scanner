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

---

## Requirements

    Bash shell
    cURL
    ClamAV (installed automatically if not present)
    Wine (installed automatically if not present for .exe files)
    unzip (installed automatically if not present for .zip files)
    unrar (installed automatically if not present for .rar files)
