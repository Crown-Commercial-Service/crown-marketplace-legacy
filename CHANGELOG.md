# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Small change...
  In all seriousness this is something I’ve wanted to do for a while.
  I have made generic framework and supplier models that can be used by all the frameworks in this service.
  This should make managing and adding new services and frameworks easier going forward ([PR 1996](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1996))
- Make jurisdiction more like a lot service to help with Legal Panel for Government ([PR 2001](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2001))
- Add the first set of code for Legal Panel for Government ([PR 2000](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2000))
- Upgrade Bun to v1.2.18 ([PR 2000](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2000))

## [5.1.0] - 2025-06-30

### Added

- Add the MCF4 lot document ([PR 1976](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1976))

### Changed

- Set the correct dates for MCF3 and MCF4 ([PR 1976](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1976))
- Upgrade CCS Frontend Helpers version to v2.5.0 ([PR 1985](https://github.com/Crown-Commercial-Service/crown-marketplace/pull/1985))
- Update the MCF4 lot document ([PR 1981](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1981))

## [5.0.1] - 2025-06-13

### Fixed

 - Make sure DfE Sign In button uses a form ([PR 1967](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1967))

## [5.0.0] - 2025-06-09

### Changed

- Upgrade Rails to v7.2.2.1 ([PR 1898](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1898))
- Use Bun to manage our assets ([PR 1898](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1898))
- Use the `DistributedLocks` to prevent concurrent uploads of data ([PR 1898](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1898))
- Upgrade Bun to v1.2.13 ([PR 1922](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1922))
- Upgrade CCS Frontend Helpers version to v2.4.0 ([PR 1923](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1923))
- Upgrade CCS Frontend version to v1.4.1 ([PR 1923](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1923))
- Upgrade ruby version to v3.4.3 ([PR 1931](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1931))
- Replace our `omniauth_openid_connect` fork with the actual gem as it now being supported ([PR 1932](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1932))
- Upgrade Rails to v8.0.2.0 ([PR 1960](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1960))

## [4.2.0] - 2025-01-23

### Changed

- Upgrade ruby version to v3.4.1 ([PR 1783](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1783))
- Upgrade alpine version to v3.21 ([PR 1783](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1783))
- Upgrade CCS Frontend Helpers version to v2.1.0 ([PR 1782](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1782))
- Upgrade CCS Frontend version to v1.3.2 ([PR 1780](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1780))
- Upgrade ruby version to v3.3.6 ([PR 1725](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1725))
- Update Node version to LTS version Jod (v22.11.0) ([PR 1713](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1713))
- Upgrade CCS Frontend Helpers version to v2.0.0 ([PR 1713](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1713))
- Upgrade CCS Frontend version to v1.2.0 ([PR 1713](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1713))
- Update alpine to v3.20 ([PR 1621](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1621))
- Upgrade ruby version to v3.3.5 ([PR 1620](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1620))
- Upgrade ruby version to v3.3.4 ([PR 1598](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1598))

### Removed

- Remove Turbolinks as it is no longer supported ([PR 1594](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1594))

## [4.1.1] - 2024-08-22

### Security

- Various dependency updates

## [4.1.0] - 2024-07-11

### Added

- Upgrade ruby version to v3.3.3 ([PR 1526](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1526))
- FMFR-1400 - Update the healthcheck route to check for the apps status ([PR 1524](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1524))
- Replace existing code with new components from ccs-frontend ([PR 1523](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1523))
- FMFR-1399 - Use ccs frontend for the shared assets ([PR 1487](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1487))
- FMFR-1398 - Use propshaft to build assets ([PR 1469](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1469))

### Security

- Various dependency updates

## [4.0.1] - 2024-05-30

### Fixed

- FMFR-1397 - Update email from support@ to the correct info@ ([PR 1456](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1456))

### Security

- Various dependency updates

## [4.0.0] - 2024-05-02

### Added

- Update ruby to v3.3.1 ([PR 1422](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1422))
- Update ruby to v3.3.1 ([PR 1422](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1422))
- Update ruby to v3.3.0 ([PR 1359](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1359))
- Update the browserslist DB ([PR 1333](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1333))
- Upgrade Rails to v7.1 ([PR 1150](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1150))
- Ensure shakapacker GEM and NODE versions match ([PR 1305](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1305))
- Rename cookie_preferences cookie to cookie_preferences_cmp so that it does not conflict with corporate website ([PR 1222](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1222))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Simple helpers ([PR 1172](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1172))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Table ([PR 1173](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1173))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Header and footer ([PR 1174](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1174))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Button ([PR 1175](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1175))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Cookie Banner ([PR 1176](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1176))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Pagination ([PR 1177](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1177))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Form helpers ([PR 1193](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1193))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Authentication ([PR 1194](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1194))
- FMFR-1392 - Migrate to CCS Frontend Helpers - Clean up ([PR 1180](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1180))
- Update rails sass to v6 ([PR 1025](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1025))

### Security

- Various dependency updates
