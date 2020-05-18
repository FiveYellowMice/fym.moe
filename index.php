<?php

if (in_array($_GET['lang'] ?? null, ['en', 'zh'])) {
  $presented_variant = $_GET['lang'];

} else {
  $accepted_languages = array_map(function($item) {
    return trim(explode(';', $item)[0]);
  }, explode(',', $_SERVER['HTTP_ACCEPT_LANGUAGE'] ?? ''));

  $presented_variant = 'en';
  foreach ($accepted_languages as $lang) {
    switch (explode('-', $lang)[0]) {
      case 'zh':
        $presented_variant = 'zh';
        break 2;
      case 'en':
        $presented_variant = 'en';
        break 2;
    } 
  }
}

$request_path = explode('?', $_SERVER['REQUEST_URI'])[0];
if (array_slice(explode('/', $request_path), -1)[0] == 'index.html') {
  $request_path = substr($request_path, 0, -10); // Remove trailing 'index.html'
}

header('Vary: Accept-Language');
header('X-Accel-Redirect: '.$request_path.'index.'.$presented_variant.'.html');
