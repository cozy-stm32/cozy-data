# cozy-data

Versioned offline data bundles and availability reports for Cozy STM32.

## Builder

The builder is a host Swift executable for maintainers and GitHub Actions. It is not installed by Cozy users.

Inspect the pinned inputs of a release manifest:

```sh
swift run cozy-data-builder inspect --release /path/to/release.json
```

The current command validates and prints the pinned MCU JSON, SVD and Embassy revisions. Bundle generation is added on top of the same manifest in the next increment.
