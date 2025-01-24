 <?php
/*
 * Copyright (C) 2010-2025, the Friendica project
 * SPDX-FileCopyrightText: 2010-2025 the Friendica project
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * Name: loma dunkel (dark)
 * Licence: AGPL
 * Author: Kristi H. @kmh@friendica.world feb @feb@loma.ml
 * Overwrites: nav_bg, nav_icon_color, background_color, background_image, contentbg_transp
 * Accented: Yes
 * Version: 1.0
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$menu_background_hover_color = '#' . $accentColor->darken(45);
$nav_bg = '#252728';
$link_color = '#' . $accentColor->lighten(10);
	// override ugly blue accent color
	if ( $link_color == "#33a2e0" ){
		 $link_color = "#0066ff";
	}
$nav_icon_color = '#B0B3B8';
$background_color = '#1C1C1D';
$contentbg_transp = '0';
$font_color = '#cccccc';
$font_color_darker = '#acacac';
$font_color_lighter = '#444444';
$background_image = '';
