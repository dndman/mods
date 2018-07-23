#install gnome-tools
class common::gnome_ext {
    package { [
'gnome-tweak-tool',
'gnome-shell-extensions',
'chrome-gnome-shell'
]:
	ensure => 'installed',
	require => Class['apt'],
 }

->    file { '/root/gnomeshell-extension-manage':
	ensure  => 'file',
	content => template('common/gnomeshell-extension-manage'),
	mode    => '755',
 }
->    exec {'wraps':
	command => '/root/gnomeshell-extension-manage --install --extension-id 1116 --system',
 }
->    file { '/etc/dconf/db/local.d/':
	ensure => 'directory',
 }
->    file {'/etc/dconf/db/local.d/00-extensions':
	ensure  => "file",
	content => template('common/extensions'),
	mode    => "0644",
 }
->    file {'/etc/dconf/profile/user':
	ensure  => "file",
	content => template('common/dconf_user'),
	mode    => "0644",
 }
~>    exec {'dconf_update':
	command => '/usr/bin/dconf update',
 }
}




