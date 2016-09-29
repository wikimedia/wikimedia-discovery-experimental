# Experimental Discovery Dashboards

This is a collection of in-progress dashboards and tools for exploring new features and data from Wikimedia Discovery team's services. These dashboards include graphs for features that other teams want to make themselves (but aren't high priority enough to get full analyst support) and trying out new dashboard features that may be hard and/or fragile.

The homepage for this project is [http://discovery-experimental.wmflabs.org/](http://discovery-experimental.wmflabs.org/)

## Dashboards as submodules

All of the following is done on your local clone of this repo. Once the updated references (hashes) have been merged, a script (that runs frequently) will pull the new versions and restart Shiny Server.

### Adding

```
$ git submodule add <URL to repo>.git shiny-server/<name>
$ git submodule update --init --recursive
```

### Updating the dashboards in this repository

This repository contains only the code that wraps around and
provisions the dashboards, not the dashboard itself. The dashboards
are kept as git submodules. To point the submodules at the latest
versions, use the following command:

```
$ git submodule foreach git pull origin master
```

Please remember to describe the changes in [CHANGELOG.md](CHANGELOG.md), then:

```
$ git add -A
$ git commit -m "Updating dashboards..."
$ git review
$ <git add -A && git commit --amend && git review>
```

## Testing

Download and install [Vagrant](https://www.vagrantup.com/downloads.html) & [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

```
git clone ssh://[LDAP username]@gerrit.wikimedia.org:29418/wikimedia/discovery/experimental /path/to/clone/to
cd /path/to/clone/to
vagrant up
```

Then go to [http://localhost:3838](http://localhost:3838) to see if it works.

## Additional information

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

### Maintainers

- [Mikhail Popov](https://meta.wikimedia.org/wiki/User:MPopov_(WMF))
