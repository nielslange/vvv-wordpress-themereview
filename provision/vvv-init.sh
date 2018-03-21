# Init script for VVV Auto Bootstrap Theme Review
echo "Commencing Theme Review Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS wordpress_themereview"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON wordpress_themereview.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Downloading WordPress using WP CLI"
	mkdir htdocs
	cd htdocs

	# Download WordPress.
	wp core download

	cd ..
fi

cd htdocs

if ! $(wp core is-installed); then

	# Install WordPress.
	echo "Installing WordPress using WP CLI"
	wp core config --dbname="wordpress_themereview" --dbuser=root --dbpass=root --dbhost="localhost" --extra-php <<PHP
define( 'WP_DEBUG', true );
//define( 'SCRIPT_DEBUG', true );
PHP
	wp core install --url=themereview.wordpress.dev --title="VVV Theme Review" --admin_user=admin --admin_password=password --admin_email=demo@example.com

	echo "Importing theme unit data using WP CLI"

  # Import the unit data.
  echo "Installing unit test data..."
  curl -O https://wpcom-themes.svn.automattic.com/demo/theme-unit-test-data.xml
  wp import theme-unit-test-data.xml --authors=create --allow-root
  rm theme-unit-test-data.xml

  # Replace url from unit data
  echo "Adjusting urls in database..."
  wp search-replace 'wpthemetestdata.wordpress.com' 'themereview.wordpress.dev' --skip-columns=guid --allow-root


fi

if $(wp core is-installed); then
	# Update WordPress.
	wp core update
	wp core update-db
fi

echo "Uninstalling plugins using WP CLI"
# Install Hello Dolly.
if $(wp plugin is-installed hello-dolly); then
	wp plugin uninstall hello-dolly
fi

echo "Installing plugins using WP CLI"
# Install Developer.
if ! $(wp plugin is-installed developer); then
	wp plugin install developer --activate
fi

# Install Theme Check.
if ! $(wp plugin is-installed theme-check); then
	wp plugin install theme-check --activate
fi

# Install Theme Mentor.
if ! $(wp plugin is-installed theme-mentor); then
	wp plugin install theme-mentor --activate
fi

# Install Theme Checklist.
if ! $(wp plugin is-installed theme-checklist); then
	wp plugin install theme-checklist --activate
fi

# Install What The File.
if ! $(wp plugin is-installed what-the-file); then
	wp plugin install what-the-file --activate
fi

# Install VIP Scanner.
if ! $(wp plugin is-installed vip-scanner); then
	wp plugin install vip-scanner --activate
fi

# Install Query Monitor.
if ! $(wp plugin is-installed query-monitor); then
	wp plugin install query-monitor --activate
fi

# Install WordPress Database Reset.
if ! $(wp plugin is-installed wordpress-database-reset); then
	wp plugin install wordpress-database-reset --activate
fi

# Install RTL Tester.
if ! $(wp plugin is-installed rtl-tester); then
	wp plugin install rtl-tester --activate
fi

# Install Airplane Mode.
if ! $(wp plugin is-installed airplane-mode); then
	wp plugin install https://github.com/norcross/airplane-mode/archive/master.zip
	# Rename folder name.
	cd wp-content/plugins
	mv airplane-mode-master airplane-mode
	wp plugin activate airplane-mode
	cd -
fi

# Install GitHub Updater.
if ! $(wp plugin is-installed github-updater); then
	wp plugin install https://github.com/afragen/github-updater/archive/master.zip
	# Rename folder name.
	cd wp-content/plugins
	mv github-updater-master github-updater
	wp plugin activate github-updater
	cd -
fi

echo "Update plugins using WP CLI"
wp plugin update --all

cd ..

# The Vagrant site setup script will restart Nginx for us
echo "VVV Theme Review site now installed";
