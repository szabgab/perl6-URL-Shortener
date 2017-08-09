use v6;
use Bailador;

get '/' => sub {
    template 'index.tt';
}

post '/shorten' => sub {
    my $url = request.params<url>;
    if not $url {
        return template 'index.tt', { error_missing_url => 1 };
    }
    return $url;
}

static-dir rx/ (.*) / =>  'static/';
