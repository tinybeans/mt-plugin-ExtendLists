package ExtendLists::Callbacks;
use strict;

sub pre_run {
    my $app = MT->instance;
    my $blog_id = $app->param('blog_id') || 0;
    my $plugin = MT->component('ExtendLists');
    my $scope = (!$blog_id) ? 'system' : 'blog:'.$blog_id;
    my ($enable, $label, $order);

    my $prop;
    
    # blog
    $prop->{blog}->{'theme_id'} = {
        auto => 1,
        label => MT->translate('Theme ID'),
        display => 'default',
    };
    $prop->{blog}->{'description'} = {
        auto => 1,
        label => $plugin->get_config_value('blog_description_label', $scope),
        label => $plugin->get_config_value('blog_description_order', $scope),
        display => &_display_option($plugin->get_config_value('blog_description', $scope)),
    };

    # entry
    $prop->{entry}->{keywords} = {
        auto => 1,
        label => $plugin->get_config_value('entry_keywords_label', $scope),
        order => $plugin->get_config_value('entry_keywords_order', $scope),
        display => &_display_option($plugin->get_config_value('entry_keywords', $scope)),
    };
    $prop->{entry}->{basename} = {
        auto => 1,
        label => $plugin->get_config_value('entry_basename_label', $scope),
        order => $plugin->get_config_value('entry_basename_order', $scope),
        display => &_display_option($plugin->get_config_value('entry_basename', $scope)),
    };

    # page
    $prop->{page}->{keywords} = {
        auto => 1,
        label => $plugin->get_config_value('page_keywords_label', $scope),
        order => $plugin->get_config_value('page_keywords_order', $scope),
        display => &_display_option($plugin->get_config_value('page_keywords', $scope)),
    };

    # asset
    $prop->{asset}->{class} = {
        auto => 1,
        label => 'Class',
        display => 'default',
    };
    $prop->{asset}->{description} = {
        auto => 1,
        label => 'Description',
        display => 'default',
    };
    $prop->{asset}->{file_ext} = {
        auto => 1,
        label => 'File Extension',
        display => 'default',
    };
    $prop->{asset}->{file_path} = {
        auto => 1,
        label => MT->translate('File Path'),
        display => 'default',
        sub_field => {
            class => 'sub_text',
            label => 'Description',
            display => 'default',
        },
        html =>  sub {
            my ($prop, $obj, $app) = @_;
            my $path = $obj->file_path;
            my $url = $obj->url;
            my $view = MT->translate('View');
            my $view_img = MT->static_path . 'images/status_icons/view.gif';
            my $out = qq {<span>$path</span>&nbsp;<a href="$url" class="sub_text"><img src="$view_img" alt="$view" /></a>};
            return $out;
        },
    };
    $prop->{asset}->{mime_type} = {
        auto => 1,
        label => MT->translate('MIME Type'),
        display => 'default',
    };

    # tag
    $prop->{tag}->{id} = {
        auto => 1,
        label => 'ID',
        order => 1,
        display => 'default',
    };
    $prop->{tag}->{'n8d_id'} = {
        auto => 1,
        label => MT->translate('Regular Tag ID'),
        display => 'default',
    };

    # field
    $prop->{field}->{'basename'} = {
        auto => 1,
        label => $plugin->get_config_value('field_basename_label', $scope),
        order => $plugin->get_config_value('field_basename_order', $scope),
        display => &_display_option($plugin->get_config_value('field_basename', $scope)),
    };
    $prop->{field}->{'default'} = {
        auto => 1,
        label => $plugin->get_config_value('field_default_label', $scope),
        order => $plugin->get_config_value('field_default_order', $scope),
        display => &_display_option($plugin->get_config_value('field_default', $scope)),
    };
    $prop->{field}->{'required'} = {
        auto => 1,
        label => $plugin->get_config_value('field_required_label', $scope),
        order => $plugin->get_config_value('field_required_order', $scope),
        html => sub {
            my ($prop, $obj, $app) = @_;
            my $required = $obj->required;
            return $required ? MT->translate('Required') : '';
        },
        display => &_display_option($plugin->get_config_value('field_required', $scope)),
    };

    # log
    $prop->{log}->{id} = {
        auto => 1,
        label => 'ID',
        order => 1,
        display => 'default',
    };
    $prop->{log}->{author_id} = {
        auto => 1,
        label => 'Author ID',
        display => 'default',
    };
    $prop->{log}->{blog_id} = {
        auto => 1,
        label => 'Blog ID',
        display => 'default',
    };
    $prop->{log}->{category} = {
        auto => 1,
        label => 'Category',
        display => 'default',
    };
    $prop->{log}->{class} = {
        auto => 1,
        label => 'Class',
        display => 'default',
    };
    $prop->{log}->{category} = {
        auto => 1,
        label => 'Category',
        display => 'default',
    };

    $plugin->registry({list_properties => $prop});

}

sub _display_option {
    my ($n) = @_;
    return $n ? 'default': 'none';
}

1;