# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Update how the show pages are displayed to help with editing ([PR 2159](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2159))

## [6.3.0] - 2025-10-28

### Added

- Moved some rake tasks into `DataLoader` module to allow them to be run using SideKiq ([PR 2114](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2114))
- Add the buyer details section for Legal Panel for Government ([PR 2121](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2121))
- Add new Information about requirement step for LPfG journey ([PR 2125](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2125))
- Add the ability to update the supplier details ([PR 2144](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2144))
- Add ability to download the rates for comparison ([PR 2145](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2145))
- Added additional logs on user's searches for LPfG ([PR 2153](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2153))

### Changed

- Added the `category` attribute to the jurisdictions ([PR 2104](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2104))
- Updated the copy on the landing page for LPfG ([PR 2123](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2123))
- Upgrade ruby version to v3.4.7 ([PR 2124](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2124))
- Updated copy for LPfG pages ([PR 2125](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2125))
- Update GOV.UK Frontend and CCS Frontend ([PR 2133](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2133))
- Updated the LPfG search report to add new questions from journey ([PR 2136](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2136))
- Freeze the left hand column when viewing the supplier rates for comparison ([PR 2136](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2136))
- Changed 'position' to 'grade' ([PR 2145](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2145))

### Fixed

- Fix issue where organisation sector name was not being shown correctly ([PR 2126](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2126))
- Fix issue where the date validation for checking a real date was not triggering ([PR 2134](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2134))

### Security

- Fix issue where send was taking an unsafe parameter as an argument to find framework ([PR 2154](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2154))

## [6.2.0] - 2025-09-22

### Added

- Add admin sections to view the supplier data ([PR 2077](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2077))

### Changed

- Update CCS Frontend with the new CCS branding ([PR 2071](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2071))
- Update positions to belong to the lot to make them easier to work with ([PR 2090](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2090))

## [6.1.0] - 2025-08-21

### Changed

- Update how UK bank holiday dates are managed ([PR 2045](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2045))

### Added

- Updated the admin sections for the legacy services to include the ability to generate reports of user activity ([PR 2034](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2034))

### Fixed

- Fix issue of the date items not being copied and so making the HTML very large ([PR 2035](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2035))
- Fixed an issue where supplier duns numbers were saved looking as a float (with a .0) and not as an int ([PR 2060](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2060))

### Removed

- Now that the update has happened to the the supplier data to make it generic, we can remove the old tables ([PR 2061](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2061))

## [6.0.0] - 2025-08-07

### Added

- Add the first set of code for Legal Panel for Government ([PR 2000](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2000))
- Add the next set of code for Legal Panel for Government with supplier results ([PR 2003](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2003))
- Add the admin upload Legal Panel for Government ([PR 2016](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2016))
- Add supplier comparison for Legal Panel for Government ([PR 2023](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2023))

### Changed

- Small change...
  In all seriousness this is something I’ve wanted to do for a while.
  I have made generic framework and supplier models that can be used by all the frameworks in this service.
  This should make managing and adding new services and frameworks easier going forward ([PR 1996](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/1996))
- Make jurisdiction more like a lot service to help with Legal Panel for Government ([PR 2001](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2001))
- Upgrade Bun to v1.2.18 ([PR 2000](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2000))
- Use javascript for file uploads ([PR 2002](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/pull/2002))

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
