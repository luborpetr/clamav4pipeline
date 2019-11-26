# clamav4pipeline
The `clamav4pipeline` is a command line tool which can be used to run ClamAV antivirus scan on top of specified directory.
The latest `clamav4pipeline` docker image contains latest virus database that is updated twice a day.

## Behaviour
When the `clamav4pipeline` is executed the scan progress is printed to the standard out.
Overall report is generated in specified directory at the end of the run.
The `clamav4pipeline` returns exit code `1` when there are infected files `0` otherwise.

## Usage
### Docker
```
# Directory to be scanned
SCAN_DIR=/tmp
# Output directory for the scanner log
OUTPUT_DIR=/tmp
docker run -v $SCAN_DIR/:/workdir/:ro \
           -v $OUTPUT_DIR/:/output/:rw \
           -it --rm thalesgroup/clamav4pipeline:latest \
           scan.sh -d /workdir -l /output/log
```
### GitLab CI/CD
```
clamav_scan:
  variables:
    SCAN_LOG: "av.log"
  stage: test
  dependencies:
    - install
  image:
    name: thalesgroup/clamav4pipeline:latest
  only:
    - branches
    - tags
    - merge_requests
  before_script: []
  script:
    - scan.sh -d . -l ${SCAN_LOG}
  artifacts:
    paths:
      - ${SCAN_LOG}
```
### GitHub Actions
```
clamav_scan:
    runs-on: [ubuntu-latest]
    container: 
      image: thalesgroup/clamav4pipeline:latest
      
    steps:
      - uses: actions/checkout@v1
      - name: Download build artefact
        uses: actions/download-artifact@v1
        with:
          name: build
      - name: AV Scan
        run: scan.sh -d . -l av.log
      - run: chmod a+r av.log
      - name: Upload AV scan artefacts
        uses: actions/upload-artifact@v1
        with:
          name: av_scan
          path: "av.log"
```

