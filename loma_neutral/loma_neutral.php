<?php
/*
 * Name: loma neutral
 * Licence: AGPL
 * Author: Matthias/E <@one@loma.ml>
 * Overwrites: nav_bg, nav_icon_color, link_color, background_color, background_image, contentbg_transp
 * Accented: yes
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$menu_background_hover_color = '#' . $accentColor->darken(45);
$nav_bg = '#' . $accentColor->darken(1);
$link_color = '#' . $accentColor->getHex();
$nav_icon_color = '#fff'; // Weiß
$background_color = '#F0F2F5'; // Facebook Hintergrundfarbe
$contentbg_transp = '98';
$font_color = '#1C1E21'; // Facebook Textfarbe
$font_color_darker = '#000';
$background_image = '';
?>

