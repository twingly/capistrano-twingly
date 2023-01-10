# Changelog

## [v4.1.0](https://github.com/twingly/capistrano-twingly/tree/v4.1.0) (2023-01-10)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v4.0.4...v4.1.0)

**Fixed bugs:**

- Deploy broken in macOS 13 because of DNS issues [\#68](https://github.com/twingly/capistrano-twingly/issues/68)

**Merged pull requests:**

- Use datacenter gateway as fallback DNS server [\#69](https://github.com/twingly/capistrano-twingly/pull/69) ([roback](https://github.com/roback))
- Keep GitHub Actions file up-to-date [\#67](https://github.com/twingly/capistrano-twingly/pull/67) ([roback](https://github.com/roback))

## [v4.0.4](https://github.com/twingly/capistrano-twingly/tree/v4.0.4) (2022-06-28)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v4.0.3...v4.0.4)

**Merged pull requests:**

- Use net-ssh ~\> 7.0 [\#66](https://github.com/twingly/capistrano-twingly/pull/66) ([Pontus4](https://github.com/Pontus4))
- Run CI on latest Rubies [\#64](https://github.com/twingly/capistrano-twingly/pull/64) ([walro](https://github.com/walro))
- Ruby 3.0.0 on CI [\#62](https://github.com/twingly/capistrano-twingly/pull/62) ([walro](https://github.com/walro))

## [v4.0.3](https://github.com/twingly/capistrano-twingly/tree/v4.0.3) (2021-01-14)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v4.0.2...v4.0.3)

**Implemented enhancements:**

- Deprecation warnings from capistrano-bundler [\#61](https://github.com/twingly/capistrano-twingly/issues/61)

**Merged pull requests:**

- Explicitly use the git plugin [\#60](https://github.com/twingly/capistrano-twingly/pull/60) ([walro](https://github.com/walro))
- Trigger CI on pull-request events [\#59](https://github.com/twingly/capistrano-twingly/pull/59) ([walro](https://github.com/walro))

## [v4.0.2](https://github.com/twingly/capistrano-twingly/tree/v4.0.2) (2020-11-24)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v4.0.1...v4.0.2)

**Fixed bugs:**

- Cannot published gem using "rake release" [\#48](https://github.com/twingly/capistrano-twingly/issues/48)

**Merged pull requests:**

- Move to GitHub actions [\#58](https://github.com/twingly/capistrano-twingly/pull/58) ([Chrizpy](https://github.com/Chrizpy))
- Update Capistrano [\#57](https://github.com/twingly/capistrano-twingly/pull/57) ([Pontus4](https://github.com/Pontus4))
- Ruby 2.7 support [\#56](https://github.com/twingly/capistrano-twingly/pull/56) ([walro](https://github.com/walro))
- Newer Ruby on Travis [\#54](https://github.com/twingly/capistrano-twingly/pull/54) ([roback](https://github.com/roback))

## [v4.0.1](https://github.com/twingly/capistrano-twingly/tree/v4.0.1) (2019-05-02)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v4.0.0...v4.0.1)

**Fixed bugs:**

- Initial deploy for systemd fails since \#47 [\#49](https://github.com/twingly/capistrano-twingly/issues/49)

**Merged pull requests:**

- Make sure systemd target is loaded before trying to stop it [\#50](https://github.com/twingly/capistrano-twingly/pull/50) ([roback](https://github.com/roback))

## [v4.0.0](https://github.com/twingly/capistrano-twingly/tree/v4.0.0) (2019-04-29)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v3.0.0...v4.0.0)

**Closed issues:**

- Add systemd support [\#45](https://github.com/twingly/capistrano-twingly/issues/45)

**Merged pull requests:**

- Generate systemd config in addition to upstart [\#47](https://github.com/twingly/capistrano-twingly/pull/47) ([roback](https://github.com/roback))

## [v3.0.0](https://github.com/twingly/capistrano-twingly/tree/v3.0.0) (2018-11-08)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.4.1...v3.0.0)

**Merged pull requests:**

- Remove LKP traces [\#44](https://github.com/twingly/capistrano-twingly/pull/44) ([walro](https://github.com/walro))

## [v2.4.1](https://github.com/twingly/capistrano-twingly/tree/v2.4.1) (2018-10-05)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.4.0...v2.4.1)

## [v2.4.0](https://github.com/twingly/capistrano-twingly/tree/v2.4.0) (2018-10-04)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.3.0...v2.4.0)

**Merged pull requests:**

- Each server can have different Procfiles [\#43](https://github.com/twingly/capistrano-twingly/pull/43) ([roback](https://github.com/roback))

## [v2.3.0](https://github.com/twingly/capistrano-twingly/tree/v2.3.0) (2018-10-04)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.2.0...v2.3.0)

**Merged pull requests:**

- Lookup app servers using multiple SRV records [\#42](https://github.com/twingly/capistrano-twingly/pull/42) ([roback](https://github.com/roback))

## [v2.2.0](https://github.com/twingly/capistrano-twingly/tree/v2.2.0) (2017-12-18)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.1.0...v2.2.0)

**Implemented enhancements:**

- Support ed25519 SSH keys [\#38](https://github.com/twingly/capistrano-twingly/issues/38)
- Release gem to rubygems.org [\#24](https://github.com/twingly/capistrano-twingly/issues/24)

**Merged pull requests:**

- Be able to use the gem with ssh-ed25519 keys [\#39](https://github.com/twingly/capistrano-twingly/pull/39) ([dentarg](https://github.com/dentarg))

## [v2.1.0](https://github.com/twingly/capistrano-twingly/tree/v2.1.0) (2016-09-22)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.0.1...v2.1.0)

**Fixed bugs:**

- foreman isn't defined as an dependency [\#29](https://github.com/twingly/capistrano-twingly/issues/29)

**Merged pull requests:**

- Various improvements to be able to DRY up config in our apps [\#36](https://github.com/twingly/capistrano-twingly/pull/36) ([dentarg](https://github.com/dentarg))
- Add foreman as a dependency [\#30](https://github.com/twingly/capistrano-twingly/pull/30) ([jage](https://github.com/jage))

## [v2.0.1](https://github.com/twingly/capistrano-twingly/tree/v2.0.1) (2016-09-06)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v2.0.0...v2.0.1)

## [v2.0.0](https://github.com/twingly/capistrano-twingly/tree/v2.0.0) (2016-06-13)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.8.0...v2.0.0)

**Implemented enhancements:**

- Webserver is hardcoded [\#20](https://github.com/twingly/capistrano-twingly/issues/20)

**Merged pull requests:**

- Use generic socket name [\#27](https://github.com/twingly/capistrano-twingly/pull/27) ([jage](https://github.com/jage))

## [v1.8.0](https://github.com/twingly/capistrano-twingly/tree/v1.8.0) (2016-05-03)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.7.1...v1.8.0)

**Merged pull requests:**

- Send process output to syslog [\#26](https://github.com/twingly/capistrano-twingly/pull/26) ([roback](https://github.com/roback))

## [v1.7.1](https://github.com/twingly/capistrano-twingly/tree/v1.7.1) (2015-02-16)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.7.0...v1.7.1)

## [v1.7.0](https://github.com/twingly/capistrano-twingly/tree/v1.7.0) (2014-12-09)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.6.2...v1.7.0)

**Fixed bugs:**

- Cancel deploy if we get 0 servers from SRV record [\#17](https://github.com/twingly/capistrano-twingly/issues/17)

**Closed issues:**

- Deployed failed, but git tag was pushed \("No Matching Host"\) [\#14](https://github.com/twingly/capistrano-twingly/issues/14)

**Merged pull requests:**

- Fail if no servers \(SRV-records\) are found [\#22](https://github.com/twingly/capistrano-twingly/pull/22) ([jage](https://github.com/jage))

## [v1.6.2](https://github.com/twingly/capistrano-twingly/tree/v1.6.2) (2014-09-19)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.6.1...v1.6.2)

## [v1.6.1](https://github.com/twingly/capistrano-twingly/tree/v1.6.1) (2014-07-28)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.6.0...v1.6.1)

**Implemented enhancements:**

- Disable autostart when stopping an application [\#15](https://github.com/twingly/capistrano-twingly/issues/15)

**Merged pull requests:**

- Add ability to control autostart in upstart [\#21](https://github.com/twingly/capistrano-twingly/pull/21) ([jage](https://github.com/jage))

## [v1.6.0](https://github.com/twingly/capistrano-twingly/tree/v1.6.0) (2014-07-28)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.5.1...v1.6.0)

## [v1.5.1](https://github.com/twingly/capistrano-twingly/tree/v1.5.1) (2014-05-12)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.5.0...v1.5.1)

**Implemented enhancements:**

- Create temporary files in tmp/ [\#9](https://github.com/twingly/capistrano-twingly/issues/9)

## [v1.5.0](https://github.com/twingly/capistrano-twingly/tree/v1.5.0) (2014-05-12)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.4.0...v1.5.0)

## [v1.4.0](https://github.com/twingly/capistrano-twingly/tree/v1.4.0) (2014-03-31)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.3.0...v1.4.0)

**Merged pull requests:**

- Make it easy to deploy the current git branch [\#13](https://github.com/twingly/capistrano-twingly/pull/13) ([dentarg](https://github.com/dentarg))
- If system/maintenance.html exist, show it [\#12](https://github.com/twingly/capistrano-twingly/pull/12) ([jage](https://github.com/jage))

## [v1.3.0](https://github.com/twingly/capistrano-twingly/tree/v1.3.0) (2014-03-26)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.2.1...v1.3.0)

**Merged pull requests:**

- Fix deploy namespace for Nginx tasks in README. [\#11](https://github.com/twingly/capistrano-twingly/pull/11) ([benmanns](https://github.com/benmanns))

## [v1.2.1](https://github.com/twingly/capistrano-twingly/tree/v1.2.1) (2014-02-14)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.1.1...v1.2.1)

**Closed issues:**

- Add stage name to git deploy tag [\#8](https://github.com/twingly/capistrano-twingly/issues/8)

## [v1.1.1](https://github.com/twingly/capistrano-twingly/tree/v1.1.1) (2014-02-11)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.0.1...v1.1.1)

## [v1.0.1](https://github.com/twingly/capistrano-twingly/tree/v1.0.1) (2014-02-11)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v1.0.0...v1.0.1)

**Closed issues:**

- Bug in nginx.rake [\#6](https://github.com/twingly/capistrano-twingly/issues/6)

## [v1.0.0](https://github.com/twingly/capistrano-twingly/tree/v1.0.0) (2014-02-11)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v0.1.4...v1.0.0)

## [v0.1.4](https://github.com/twingly/capistrano-twingly/tree/v0.1.4) (2014-02-10)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v0.1.3...v0.1.4)

**Implemented enhancements:**

- nginx task requires constants [\#3](https://github.com/twingly/capistrano-twingly/issues/3)

## [v0.1.3](https://github.com/twingly/capistrano-twingly/tree/v0.1.3) (2014-02-04)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v0.1.2...v0.1.3)

**Fixed bugs:**

- HTTPS support missing [\#4](https://github.com/twingly/capistrano-twingly/issues/4)

## [v0.1.2](https://github.com/twingly/capistrano-twingly/tree/v0.1.2) (2014-01-31)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v0.1.1...v0.1.2)

## [v0.1.1](https://github.com/twingly/capistrano-twingly/tree/v0.1.1) (2014-01-15)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/v0.1.0...v0.1.1)

**Implemented enhancements:**

- Make repo public [\#2](https://github.com/twingly/capistrano-twingly/issues/2)

## [v0.1.0](https://github.com/twingly/capistrano-twingly/tree/v0.1.0) (2014-01-14)

[Full Changelog](https://github.com/twingly/capistrano-twingly/compare/0c5897c038d57e7acf3551a0c0b778571c9f293f...v0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
