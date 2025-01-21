<?php
/*
 * Copyright (C) 2010-2024, the Friendica project
 * SPDX-FileCopyrightText: 2010-2024 the Friendica project
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 *
 * Name: loma dunkel (dark)
 * Licence: AGPL
 * Author: Kristi H. @kmh@friendica.world feb @feb@loma.ml
 * Overwrites: nav_bg, nav_icon_color, link_color, background_color, background_image, contentbg_transp
 * Accented: No
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);

$nav_bg = '#252728';
$nav_icon_color = '#B0B3B8';
$link_color = '#0866ff';
$background_color = '#1C1C1D';
$background_image = '';
$contentbg_transp = 100;
$menu_background_hover_color = 'rgba(255,255,255,.1)'; // rgba(255,255,255,.1)
$font_color = '#B0B3B8';
$font_color_darker = '#333';
$border_color = '#333';
