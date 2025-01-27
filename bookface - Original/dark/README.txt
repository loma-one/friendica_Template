BOOKFACE FOR FRIENDICA
===============================

Description:
A Friendica Theme Template/Scheme for the "Frio" theme that gives it a modern makeover.

Disclaimer: This is a Work-In-Progress, use in production at your own risk!

1. Drop these four files 
	* bookface_dark.css
	* bookface_dark.php
	* bookface_light.css
	* bookface_light.php
into /friendica/view/theme/frio/scheme/

2. Go to Settings > Display > Theme Customization > Appearance
	a. Select either "Bookface Light" or "Bookface Dark"
	b. (optional) Select Accent Color
	c. click "Submit" button.

NOTES:

* This theme HIDES the attachment upload button in the file browser since there is no way to manage/delete uploaded files, and this is confusing to users.
* Overrides nav_bg, nav_icon_color, background_color, background_image, and contentbg_transp
* Overrides "Frio" blue accent color with one that looks nicer with these schemes.
* This scheme is still being revised as new things to style are discovered.
* This scheme was adapted from a user stylesheet for use in browsers on the client-side.

CHANGELOG:
1.2
* "Save" buttons for "Remote Servers" settings normalized to right.
* "Close" button and open "Compose" button restyled, "Close" enlarged for better touch target.
* Open Compose Page button styled to match roundy buttons.
* "Save Search" buttons styles to match "Compose" and "Mention" buttons.
* Dark version Settings container background color fixed.
* Comment Box background fixed.
* Compose/Comment text style buttons enlarged for better touch targets, styled to match on Compose Modal, Compose Page, and Comment below post.
* Aside Selected Menu item now adopts color scheme.
* All Modal File browsers now styled the same.
* IFRAME container positioned and styled (usually used for embedded video)
* Fixed "Like/Dislike" on photos showing label twice.
* TopBar Second vcard short photo made round.

1.1
* Fixes long lists of tags/mentions spilling out of post or profile container, forces them to wrap to multiple rows as necessary.
* Adds spacing to left of multiple settings buttons floated to right.

1.0
* Initial release of server-side version
* Accent colors now work (server-side version only)
* Compose Title border radius normalized to rest of inputs.
* Top Bar buttons fixed for small mobile screens.
* Delegate "Save" settings button normalized to right side.
* Form input background colors normalized.

0.4 (18 Jan 2025)
* Adds "superscript" engagement numbers to mobile Action Buttons.
* Settings "Submit" buttons normalized to right-hand placement.
* "Mention" button and "Compose" buttons sizing normalized.
* Compose Modal/Page and Reply now styled.
* File Attachment Button hidden in Compose File Browser.
* Adjustment to Event RSVP buttons for both desktop and mobile.
* Styling and adjustment to Profile Extra links.
* Changed Network Links from "Link:" text to buttons style with chevron.

0.3 (16 Jan 2025)
* Light and Dark mode user stylesheets.
* Light version first adapted to theme template/scheme for server-side.
* Added "superscript" engagement numbers to desktop Action Buttons

0.2 (13 Jan 2025)
* Added labels to Action Buttons.

0.1 (12 Jan 2025)
* Based on original bookface.css user stylesheet (light mode only)

Contributors:
Kristi H. @kmh@friendica.world
feb @feb@loma.ml

License: AGPL 3.0 or Later

