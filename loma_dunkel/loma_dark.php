<?php
/*
 * Name: Loma dunkel
 * Licence: AGPL
 * Author: Matthias Ebers <feb@loma.ml>
 * Overwrites: nav_bg, nav_icon_color, link_color, background_color, background_image, contentbg_transp
 * Accented: yes
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$menu_background_hover_color = '#' . $accentColor->darken(45);
$nav_bg = '#2f3335';
#$link_color = '#' . $accentColor->lighten(10);
$link_color = '#776e61';
$nav_icon_color = '#f5f0eb';
$background_color = '#1c1e1f';
$contentbg_transp = '0';
$font_color = '#cccccc';
$font_color_darker = '#acacac';
$font_color_lighter = '#444444';
$background_image = '';

$font_color = '#e4e4e4';
$font_color_darker = '#dcdcdc';
$font_color_lighter = '#555555';
$background_image = '';
