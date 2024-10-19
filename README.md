# fio-test-suite
Fio benchmarks I run on all my homelab storage

To run test suite on a raw disk
```FILENAME=/dev/XXX DIRECT=1 fio testsuite.fio --output=testsuiteresults-raw.csv```

To run test suite on file system with caching
```FILENAME=/path/to/file DIRECT=0 fio testsuite.fio --output=testsuiteresults-fs.csv``