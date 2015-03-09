#!/usr/bin/perl
use CGI;
use Digest::SHA qw (hmac_sha1_base64);
use JSON;
use strict;

#login as provisioned in voxbone
my $user = 'username';
#shared secret as provisioned by voxbone;
my $secret = 'secret';

#if you want to validate http-referrer to make sure only your website is 
#accessing the auth servlet, set these values, otherwise set them to undef
my $http_url = "http://mywebsite.com/click-to-call";
my $https_url = "https://mywebsite.com/click-to-call";

sub make_api_key
{
	my $user = shift;
	my $secret = shift;
	my $ts = shift;

	my $password = hmac_sha1_base64($ts . ':' . $user, $secret);

	while (length($password) % 4) {
		$password .= '=';
	}

	return $password;
}

my $ttl = 300;
my $expire = time + $ttl;


my $q = CGI->new;
my $password = make_api_key($user, $secret, $expire);
print $q->header('text/javascript');

my @url_parts = split('\?', $ENV{'HTTP_REFERER'},2);
my $origin = shift @url_parts;


if((!defined $http_url || $origin ne $http_url) && (!defined $https_url || $origin ne $https_url))
{
	print "var voxrtc_config = {};\n";
	exit;
}

my $response_map;
$response_map->{'username'} = $user;
$response_map->{'expires'} =  $expire;
$response_map->{'key'} = $password;

print 'var voxrtc_config = ' . to_json($response_map).";\n";

my $env_map;
my $key;

