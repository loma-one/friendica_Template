<?php
/*
 * Name: loma hell
 * Licence: AGPL
 * Author: Matthias/E <@one@loma.ml>
 * Overwrites: nav_bg, nav_icon_color, link_color, background_color, background_image, contentbg_transp
 * Accented: yes
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$menu_background_hover_color = '#' . $accentColor->darken(45);
$nav_bg = '#31363c';
#$link_color = '#' . $accentColor->lighten(10);
$link_color = '#566d7f';
$nav_icon_color = '#ffffff';
$background_color = '#fafafa';
$contentbg_transp = '98';
$font_color = '#1e1e1e';
$font_color_darker = '#000000';
$background_image = '';
