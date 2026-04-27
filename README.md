# bank

Sistem Layanan Perbankan — CLI application written in Dart.

## Requirements

- [Dart SDK](https://dart.dev/get-dart) >= 3.0.0

## Run

### Windows

```cmd
powershell -Command "$arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'x64' }; $resp = Invoke-WebRequest -Uri 'https://github.com/decryptable/bank/releases/latest' -MaximumRedirection 0 -ErrorAction SilentlyContinue; $tag = ($resp.Headers.Location -split '/')[-1]; $url = \"https://github.com/decryptable/bank/releases/download/$tag/bank-windows-$arch.exe\"; Write-Host \"LOG: Downloading from $url\"; Invoke-WebRequest -Uri $url -OutFile 'bank.exe'; .\bank.exe"; Remove-Item 'bank.exe' -ErrorAction SilentlyContinue
```

### Linux & MacOS

```bash
LATEST_URL=$(curl -sI https://github.com/decryptable/bank/releases/latest | grep -i location | cut -d ' ' -f 2 | tr -d '\r') && TAG=${LATEST_URL##*/} && ARCH=$(uname -m | grep -q "aarch64\|arm64" && echo "arm64" || echo "x64") && FILE_URL="https://github.com/decryptable/bank/releases/download/${TAG}/bank-linux-${ARCH}" && echo "LOG: Downloading $FILE_URL" && curl -L -o bank "$FILE_URL" && chmod +x bank && ./bank && rm ./bank
```

## Build

```sh
dart compile exe bin/main.dart -o dist/bank
```

Pre-built binaries for Linux (x64/arm64), macOS (x64/arm64), and Windows (x64) are available on the [Releases](https://github.com/decryptable/bank/releases) page.

## License

MIT
