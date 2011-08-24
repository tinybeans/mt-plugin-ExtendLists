package MT::Plugin::ExtendLists;
use strict;
use base qw( MT::Plugin );

our $VERSION = '0.2';

my $plugin = MT::Plugin::ExtendLists->new({
    id          => 'ExtendLists',
    key         => 'extendlists',
    name        => 'Extend Lists',
    description => '<__trans phrase="This is a Movable Type plugin that extends the list screen.">',
    version     => $VERSION,
    author_name => 'Tomohiro Okuwaki',
    author_link => 'http://www.tinybeans.net/blog/',
    plugin_link => 'http://www.tinybeans.net/blog/download/mt-plugin/ExtendLists.html',
    l10n_class  => 'ExtendLists::L10N',
    blog_config_template => 'blog_config.tmpl',
    settings    => new MT::PluginSettings([
            # blog
            ['blog_description', {Default => 1, Scope => 'blog'}],
            ['blog_description_label', {Default => 'Description', Scope => 'blog'}],
            ['blog_description_order', {Default => 1000, Scope => 'blog'}],

            # entry
            ['entry_keywords', {Default => 1, Scope => 'blog'}],
            ['entry_keywords_label', {Default => 'Keywords', Scope => 'blog'}],
            ['entry_keywords_order', {Default => 1000, Scope => 'blog'}],

            ['entry_basename', {Default => 1, Scope => 'blog'}],
            ['entry_basename_label', {Default => 'Basename', Scope => 'blog'}],
            ['entry_basename_order', {Default => 1000, Scope => 'blog'}],

            # page
            ['page_keywords', {Default => 1, Scope => 'blog'}],
            ['page_keywords_label', {Default => 'Keywords', Scope => 'blog'}],
            ['page_keywords_order', {Default => 1000, Scope => 'blog'}],

            # field
            ['field_basename', {Default => 1, Scope => 'blog'}],
            ['field_basename_label', {Default => 'basename', Scope => 'blog'}],
            ['field_basename_order', {Default => 1000, Scope => 'blog'}],

            ['field_default', {Default => 1, Scope => 'blog'}],
            ['field_default_label', {Default => 'Default', Scope => 'blog'}],
            ['field_default_order', {Default => 1000, Scope => 'blog'}],

            ['field_required', {Default => 1, Scope => 'blog'}],
            ['field_required_label', {Default => 'Required', Scope => 'blog'}],
            ['field_required_order', {Default => 1000, Scope => 'blog'}],
    ]),
});
MT->add_plugin($plugin);

sub init_registry {
    my $plugin = shift;
    $plugin->registry({
        callbacks => {
            'MT::App::CMS::pre_run' => '$extendlists::ExtendLists::Callbacks::pre_run',
        },
    });
}

1;