 <?php
/*
 * Copyright (C) 2010-2024, the Friendica project
 * SPDX-FileCopyrightText: 2010-2024 the Friendica project
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * Name: Bookface
 * Licence: AGPL
 * Author: Kristi H. @kmh@friendica.world> feb @feb@loma.ml>
 * Overwrites: nav_bg, nav_icon_color, link_color, background_color, background_image, contentbg_transp
 * Accented: yes
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$nav_bg = '#f2f4f7';
$nav_icon_color = '#606637';
$link_color = '#0866ff';
$background_color = '#f2f4f7';
$background_image = '';
$contentbg_transp = 100;
$menu_background_hover_color = '#8080801a'; // rgba(128,128,128,.1)
$font_color = '#65686C';
$font_color_darker = '#333';
$border_color = '#eee';
?>

