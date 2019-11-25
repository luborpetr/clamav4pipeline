# clamav-scanner
The `clamav-scanner` is a command line tool which can be used to run ClamAV antivirus scan on top of specified directory.
The latest `clamav-scanner` docker image contains latest virus database that is updated twice a day.

## Behaviour
When the `clamav-scanner` is executed the scan progress is printed to the standard out.
Overall report is generated in specified directory at the end of the run.
The `clamav-scanner` returns exit code `1` when there are infected files `0` otherwise.

## Usage
### Docker
```
# Directory to be scanned
SCAN_DIR=/tmp
# Output directory for the scanner log
OUTPUT_DIR=/tmp
docker run -v $SCAN_DIR/:/workdir/:ro \
           -v $OUTPUT_DIR/:/output/:rw \
           -it --rm clamav-scanner:latest \
           scan.sh -d /workdir -l /output/log
```
### GitLab CI/CD

### GitHub Actions
