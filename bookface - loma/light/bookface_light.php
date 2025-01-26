 <?php
/*
 * Copyright (C) 2010-2025, the Friendica project
 * SPDX-FileCopyrightText: 2010-2025 the Friendica project
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * Name: loma hell (light)
 * Licence: AGPL
 * Author: Kristi H. @kmh@friendica.world feb @feb@loma.ml
 * Overwrites: nav_bg, nav_icon_color, background_color, background_image, contentbg_transp
 * Accented: Yes
 * Version: 1.0
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$nav_bg = '#ffffff';
$nav_icon_color = '#606637';
$link_color = '#' . $accentColor->lighten(10);
	// overrid ugly blue accent color
	if ( $link_color == "#33a2e0" ){
		 $link_color = "#0066ff";
	}
$background_color = '#f2f4f7';
$background_image = '';
$contentbg_transp = 100;
$menu_background_hover_color = '#8080801a'; // rgba(128,128,128,.1)
$font_color = '#313131';
$font_color_darker = '#333';
$border_color = '#eee';


