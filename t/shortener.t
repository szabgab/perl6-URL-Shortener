use v6;
use Test;
use JSON::Fast;

use Bailador::Test;

plan 2;

%*ENV<P6W_CONTAINER> = 'Bailador::Test';
%*ENV<BAILADOR_APP_ROOT> = $*CWD.absolute;
my $app = EVALFILE "bin/app.pl6";

subtest {
    plan 4;

    my %data = run-psgi-request($app, 'GET', '/');
    my $html = %data<response>[2];
    %data<response>[2] = '';
    is-deeply %data<response>, [200, ["Content-Type" => "text/html"], ''], 'route GET /';
    is %data<err>, '';
    #diag $html;
    ok index($html, '<title>URL Shortener</title>') !=== Nil;
    ok index($html, 'Missing URL') === Nil;
}, '/';


subtest {
    plan 4;

    my %data = run-psgi-request($app, 'POST', '/shorten');
    my $html = %data<response>[2];
    %data<response>[2] = '';
    is-deeply %data<response>, [200, ["Content-Type" => "text/html"], ''], 'route POST /shorten';
    is %data<err>, '';
    #diag $html;
    ok index($html, '<title>URL Shortener</title>') !=== Nil;
    ok index($html, 'Missing URL') !=== Nil;
}, '/';

