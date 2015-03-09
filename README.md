webrtc-auth-perl
================
This projects aims to provide an easy way for Voxbone customer to integrate WebRTC ephemeral authentication on their website.

After downloading update the variables found at the beginning of the perl script

```
#login as provisioned in voxbone
my $user = 'username';
#shared secret as provisioned by voxbone;
my $secret = 'secret';

#if you want to validate http-referrer to make sure only your website is 
#accessing the auth servlet, set these values, otherwise set them to undef
my $http_url = "http://mywebsite.com/click-to-call";
my $https_url = "https://mywebsite.com/click-to-call";
```


After doing the needed modifications, upload it to the cgi-bin directory of your webserver.

To use it add the following to your html code:
```
<script src="/cgi-bin/rtc_auth.pl"></script>
<script src="https://webrtc.voxbone.com/js/voxbone-0.0.2.js"></script>
<script src="https://webrtc.voxbone.com/js/jssip-0.3.0.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
```

You should then be ready to make your first call! :-)
