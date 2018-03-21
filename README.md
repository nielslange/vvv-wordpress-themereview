# VVV WordPress Theme Review

Set up a VV WordPress Theme Review environment

## Configuration

1. If Vagrant is running, stop it via `vagrant halt`
2. Open `vvv-custom.yml` and add the following configuration:

	```
	wordpress-themereview:
	repo: https://github.com/nielslange/vvv-wordpress-themereview.git
	hosts:
	  - themereview.wordpress.test
	```

3. Start and provision vagrant via `vagrant up --provision` 

## Plugins

- Install WordPress and import [Theme Unit Test Data](https://github.com/WPTRT/theme-unit-test)
- Uninstall [Hello Dolly](https://wordpress.org/plugins/hello-dolly/)
- Install & activate [Developer](https://wordpress.org/plugins/developer/)
- Install & activate [Theme Check](https://wordpress.org/plugins/theme-check/)
- Install & activate [Theme Mentor](https://wordpress.org/plugins/theme-mentor/)
- Install & activate [Theme Checklist](https://wordpress.org/plugins/theme-checklist/)
- Install & activate [What The File](https://wordpress.org/plugins/what-the-file/)
- Install & activate [VIP Scanner](https://wordpress.org/plugins/vip-scanner/)
- Install & activate [Query Monitor](https://wordpress.org/plugins/query-monitor/)
- Install & activate [WordPress Database Reset](https://wordpress.org/plugins/wordpress-database-reset)
- Install & activate [RTL Tester](https://wordpress.org/plugins/rtl-tester/)
- Install & activate [Airplane Mode](https://github.com/norcross/airplane-mode/archive/)
- Install & activate [GitHub Updater](https://github.com/afragen/github-updater/)

## Credentials

**Theme**

- host: `themereview.wordpress.test`
- user: `admin`
- pass: `password`

**phpMyAdmin**

- host: `https://vvv.test/database-admin/`
- user: `root` (internal access) or `external` (external access)
- pass: `root` (internal access) or `external` (external access)

## Thanks

- [Konstantin Obenland](https://github.com/obenland) for helping me getting VVV up and running
- [Aubrey Portwood](https://github.com/aubreypwd) for creating the repository [wordpress-themereview-vvv](https://github.com/aubreypwd/wordpress-themereview-vvv)
- [Ulrich Pogson](https://github.com/grappler) for creating the branch [theme-review](https://github.com/grappler/theme-review) and optimizing the README.md



