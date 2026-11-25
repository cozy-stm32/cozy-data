# Contributing driver manifests

## Before you start

Develop and test your drivers in your own development package and firmware. Publish the finished Swift package and a version tag in your own Git repository. A package can provide multiple products; all products in a release share the package version.

The central catalog stores manifests, not driver source code. A public manifest may point to a private repository. Users need their own Git credentials and access to install its code; do not put credentials or tokens in a manifest or pull request. Private packages must be marked as such once the catalog schema supports that field. Until then, the private marker and its UI are planned, not implemented. Vendors may also provide sources directly without publishing here.

## Prepare manifests

The current CozyPM schema describes one device per JSON manifest. Place each catalog submission under `manifests/<vendor>/` and use a unique, namespaced `id`, such as `acme.status-led`. The vendor directory organizes contributions; it does not determine the device category.

**Preliminary example:** The manifest below is an unverified draft and may differ from a real display/touchscreen module or its driver. Do not use it as a hardware wiring reference. Manifests are generated automatically: take the generated manifest from your package instead of writing one by hand.

See [the display example](examples/acme/acme.display.json), which illustrates a combined display and touchscreen module, pin assignments, two named SPI buses with independent frequency ranges, an optional touch interrupt line and a Git package reference. The URL, package, product and device are fictional; they cannot be fetched or built. This example illustrates the existing device manifest, not an exhaustive schema specification.

For each device, provide its identity, name, category, pins, buses and `codeSource`. For a Git driver, `codeSource` identifies the package URL, release tag and SwiftPM product. Replace the example values with the actual device wiring and published package information. For multiple devices from one package, use the same package URL and release tag and name the correct product in each device manifest.

The catalog layout and the existing manifest format are documented here; support for reading nested vendor directories in Configurator is planned separately. Automated schema, tag, product and build checks are not yet available.

## Submit a pull request

1. Publish the package and its release tag in your repository.
2. Add or update the relevant manifests under your vendor directory.
3. Open a pull request targeting `next`, using the pull request template. Identify the repository, tag and affected devices, and describe the checks you performed.
4. Respond to review. Merging into `next` makes the change available for practical validation; it does not by itself promote it to stable.

Updating a package version follows the same process. Keep changes for related products consistent and explain any compatibility changes in the pull request.

## Promotion to stable

After practical validation, a maintainer selects the approved changes from `next`, prepares a separate branch and opens a pull request targeting `main`. Reference the original pull request and describe the validation performed. This permits independent promotion when other changes in `next` are not yet ready.

## Reading the example

- `schemaVersion` identifies the manifest format; the example uses version 1.
- `id` is a unique namespaced device identity. `name`, `category`, `iconName` and `summary` describe its presentation.
- `pins` describes the module connector in physical order. Each entry provides a `label`, a role and, when needed, an MCU mode and an explanatory note. Actual pin assignments and electrical limits must come from the hardware documentation.
- `buses` groups related signals. `assignments` maps bus signal names to pin labels. A configuration names its parameters, transport and permitted frequency range (`minHz`, `targetHz`, `maxHz`). The display and touch controller use separate example SPI signals; `optionalLines` marks the touch interrupt as optional. Select real limits supported by the device.
- `codeSource` selects a Git repository, tag and SwiftPM product. A tag identifies the package release, not a separate device release.

Optional fields and supported values are defined by CozyPM's versioned manifest model. This document does not claim that the example covers every peripheral or that automated validation already exists. Never include secrets in a manifest.
