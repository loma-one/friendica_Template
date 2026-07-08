// bbcode_parser.js
function parseBBCodeToHTML(text) {
    if (!text) return "";

    // 1. HTML-Sonderzeichen maskieren (Grundlegender XSS-Schutz)
    let html = text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");

    // XSS Protection gegen "javascript:" URIs in Attributen
    html = html.replace(/js|javascript:/gi, "");

    // 2. Spezielle Blockaden ([noparse], [nobb], [pre], [nosmile]) vorab schützen
    html = html.replace(/\[(?:noparse|nobb|pre)\]([\s\S]*?)\[\/(?:noparse|nobb|pre)\]/gis, '<span style="font-family:monospace; white-space:pre-wrap;">$1</span>');
    html = html.replace(/\[nosmile\]/gi, '');

    // 3. BBCode Formatierungen umwandeln
    html = html.replace(/\[b\]([\s\S]*?)\[\/b\]/gi, '<strong>$1</strong>');
    html = html.replace(/\[i\]([\s\S]*?)\[\/i\]/gi, '<em>$1</em>');
    html = html.replace(/\[u\]([\s\S]*?)\[\/u\]/gi, '<u>$1</u>');
    html = html.replace(/\[s\]([\s\S]*?)\[\/s\]/gi, '<del>$1</del>');
    html = html.replace(/\[o\]([\s\S]*?)\[\/o\]/gi, '<span style="text-decoration: overline;">$1</span>');
    html = html.replace(/\[mark\]([\s\S]*?)\[\/mark\]/gi, '<mark>$1</mark>');

    // 4. Überschriften (h1 - h6)
    html = html.replace(/\[h1\]([\s\S]*?)\[\/h1\]/gi, '<h1>$1</h1>');
    html = html.replace(/\[h2\]([\s\S]*?)\[\/h2\]/gi, '<h2>$1</h2>');
    html = html.replace(/\[h3\]([\s\S]*?)\[\/h3\]/gi, '<h3>$1</h3>');
    html = html.replace(/\[h4\]([\s\S]*?)\[\/h4\]/gi, '<h4>$1</h4>');
    html = html.replace(/\[h5\]([\s\S]*?)\[\/h5\]/gi, '<h5>$1</h5>');
    html = html.replace(/\[h6\]([\s\S]*?)\[\/h6\]/gi, '<h6>$1</h6>');

    // 5. Ausrichtungen & Linien
    html = html.replace(/\[center\]([\s\S]*?)\[\/center\]/gi, '<div style="text-align: center;">$1</div>');
    html = html.replace(/\[hr\]/gi, '<hr>');
    html = html.replace(/(?:^|<br>)\s*---\s*(?=$|<br>)/g, '<hr>');

    // 6. Farben, Schriftarten & Schriftgrößen
    html = html.replace(/\[color=(.*?)\]([\s\S]*?)\[\/color\]/gi, '<span style="color: $1;">$2</span>');
    html = html.replace(/\[font=(.*?)\]([\s\S]*?)\[\/font\]/gi, '<span style="font-family: $1;">$2</span>');
    html = html.replace(/\[size=(xx-small|x-small|small|medium|large|x-large|xx-large)\]([\s\S]*?)\[\/size\]/gi, '<span style="font-size: $1;">$2</span>');
    html = html.replace(/\[size=(\d+)(?:px)?\]([\s\S]*?)\[\/size\]/gi, '<span style="font-size: $1px;">$2</span>');

    // 7. Benutzerdefinierte Styles (Inline und Block)
    html = html.replace(/\[style=(.*?)\]([\s\S]*?)\[\/style\]/gi, '<span style="$1">$2</span>');

    // 8. Absätze & Code-Blöcke
    html = html.replace(/\[p\]([\s\S]*?)\[\/p\]/gis, '<p>$1</p>');
    html = html.replace(/\[code(?:=[^\]]*)?\]([\s\S]*?)\[\/code\]/gis, '<pre style="background: rgba(128,128,128,0.1); padding: 8px; border-radius: 4px; font-family: monospace; white-space: pre-wrap;">$1</pre>');

    // 9. Spoiler / Inhaltswarnung
    html = html.replace(/\[spoiler=(.*?)\]([\s\S]*?)\[\/spoiler\]/gis, '<details class="bb-spoiler"><summary style="cursor:pointer; font-weight:bold;">$1 (Spoiler Alarm)</summary><div style="margin-top:5px; padding:5px; border-left:2px solid #ccc;">$2</div></details>');
    html = html.replace(/\[spoiler\]([\s\S]*?)\[\/spoiler\]/gis, '<details class="bb-spoiler"><summary style="cursor:pointer; font-weight:bold;">Spoiler (Zum Öffnen klicken)</summary><div style="margin-top:5px; padding:5px; border-left:2px solid #ccc;">$1</div></details>');

    // 10. Zitate
    html = html.replace(/\[quote=([^\]]+)\]([\s\S]*?)\[\/quote\]/gi, '<blockquote><strong>$1 hat geschrieben:</strong><br>$2</blockquote>');
    html = html.replace(/\[quote\]([\s\S]*?)\[\/quote\]/gi, '<blockquote>$1</blockquote>');

    // 11. Links, Bookmarks & E-Mail
    html = html.replace(/\[url=(.*?)\]([\s\S]*?)\[\/url\]/gi, '<a href="$1" target="_blank" rel="noopener">$2</a>');
    html = html.replace(/\[url\]([\s\S]*?)\[\/url\]/gi, '<a href="$1" target="_blank" rel="noopener">$1</a>');
    html = html.replace(/\[bookmark=(.*?)\]([\s\S]*?)\[\/bookmark\]/gi, '🔖 <a href="$1" target="_blank" rel="noopener">$2</a>');
    html = html.replace(/\[bookmark\]([\s\S]*?)\[\/bookmark\]/gi, '🔖 <a href="$1" target="_blank" rel="noopener">$1</a>');
    html = html.replace(/\[mail=(.*?)\]([\s\S]*?)\[\/mail\]/gi, '<a href="mailto:$1">$2</a>');
    html = html.replace(/\[mail\]([\s\S]*?)\[\/mail\]/gi, '<a href="mailto:$1">$1</a>');

    // 12. Bilder (Konsolidierte Friendica-Syntax inkl. QuickPhoto Addon)
    html = html.replace(/\[img\]([^\]|]+)\|([\s\S]+?)\[\/img\]/gi, function(match, filename, description) {
        let imgSrc = filename.trim();
        if (!/^https?:\/\//i.test(imgSrc)) {
            imgSrc = window.location.origin + '/photo/' + imgSrc;
        }
        return '<div class="quickphoto-preview-wrapper">' +
               '<img src="' + imgSrc + '" alt="' + description + '" title="' + description + '" />' +
               '<span class="qp-desc">Beschreibung: ' + description + '</span>' +
               '</div>';
    });

    html = html.replace(/\[img=([^\]x\s|]+)\]\s*\[\/img\]/gi, '<img src="$1" style="max-width:100%; height:auto; border-radius:4px;" />');
    html = html.replace(/\[img=([^\]x\s|]+)\]([^|]*?)\[\/img\]/gi, '<img src="$1" alt="$2" title="$2" style="max-width:100%; height:auto; border-radius:4px;" />');
    html = html.replace(/\[img=(\d+)x\d+\]([^|]+?)\[\/img\]/gi, '<img src="$2" width="$1" style="height:auto; max-width:100%; border-radius:4px;" />');
    html = html.replace(/\[img\]([^|]+?)\[\/img\]/gi, '<img src="$1" style="max-width:100%; height:auto; border-radius:4px;" />');

    // 13. Multimediale Einbettungen (HTML5 Player)
    html = html.replace(/\[video\](.*?)\[\/video\]/gi, '<video src="$1" controls style="max-width:100%; max-height:300px;"></video>');
    html = html.replace(/\[audio\](.*?)\[\/audio\]/gi, '<audio src="$1" controls style="width:100%;"></audio>');
    html = html.replace(/\[embed\](.*?)\[\/embed\]/gi, '<div style="padding:10px; background:rgba(128,128,128,0.05); border:1px dashed #ccc; border-radius:4px;">📺 Internes Medium/Embed: <a href="$1" target="_blank">$1</a></div>');

    // 14. Karten ([map])
    html = html.replace(/\[map=(.*?)\]/gi, '<div style="padding:5px; background:rgba(128,128,128,0.05); border:1px solid #ddd;"><i class="ri-map-pin-line"></i> Karte zentriert auf Koordinaten: $1</div>');
    html = html.replace(/\[map\]([\s\S]*?)\[\/map\]/gi, '<div style="padding:5px; background:rgba(128,128,128,0.05); border:1px solid #ddd;"><i class="ri-map-pin-line"></i> Karte für Adresse: $1</div>');
    html = html.replace(/\[map\]/gi, '<div style="padding:5px; background:rgba(128,128,128,0.05); border:1px solid #ddd;"><i class="ri-map-pin-line"></i> Karte zentriert auf Beitragsposition</div>');

    // 15. Abstracts (Zusammenfassungen für Drittnetzwerke)
    html = html.replace(/\[abstract(?:=[^\]]*)?\]([\s\S]*?)\[\/abstract\]/gis, '');

    // 16. Tabellen-Konstrukte
    html = html.replace(/\[table(?: border=\d+)?\]([\s\S]*?)\[\/table\]/gis, '<table class="table" style="width:100%; border-collapse:collapse; border:1px solid #ccc; margin:10px 0;">$1</table>');
    html = html.replace(/\[tr\]([\s\S]*?)\[\/tr\]/gis, '<tr style="border-bottom:1px solid #eee;">$1</tr>');
    html = html.replace(/\[th\]([\s\S]*?)\[\/th\]/gis, '<th style="padding:8px; background:rgba(128,128,128,0.1); text-align:left; font-weight:bold; border:1px solid #ccc;">$1</th>');
    html = html.replace(/\[td\]([\s\S]*?)\[\/td\]/gis, '<td style="padding:8px; border:1px solid #ccc;">$1</td>');

    // 17. Listen-Strukturen (Fix für das unescaped "?"-Zeichen)
    html = html.replace(/\[li\]([\s\S]*?)(?=\[li\]|\[\/ul\]|\[\/ol\]|\[\/list\]|$)/gis, '<li>$1</li>');
    html = html.replace(/\[ul\]([\s\S]*?)\[\/ul\]/gis, '<ul>$1</ul>');
    html = html.replace(/\[ol\]([\s\S]*?)\[\/ol\]/gis, '<ol>$1</ol>');
    html = html.replace(/\[list=1\]([\s\S]*?)\[\/list\]/gis, '<ol style="list-style-type: decimal;">$1</ol>');
    html = html.replace(/\[list=i\]([\s\S]*?)\[\/list\]/gis, '<ol style="list-style-type: lower-roman;">$1</ol>');
    html = html.replace(/\[list=I\]([\s\S]*?)\[\/list\]/gis, '<ol style="list-style-type: upper-roman;">$1</ol>');
    html = html.replace(/\[list=a\]([\s\S]*?)\[\/list\]/gis, '<ol style="list-style-type: lower-alpha;">$1</ol>');
    html = html.replace(/\[list=A\]([\s\S]*?)\[\/list\]/gis, '<ol style="list-style-type: upper-alpha;">$1</ol>');
    html = html.replace(/\[list=\?\]([\s\S]*?)\[\/list\]/gis, '<ul style="list-style-type: disc;">$1</ul>');
    html = html.replace(/\[list\]([\s\S]*?)\[\/list\]/gis, '<ul style="list-style-type: disc;">$1</ul>');

    // 18. Soziale Entitäten
    html = html.replace(/(^|\s)(#[^\s\[\]]+)/gi, '$1<span style="color:#28a745; font-weight:bold;">$2</span>');
    html = html.replace(/(^|\s)(@[^\s\[\]]+)/gi, '$1<span style="color:#007bff; font-weight:bold;">$2</span>');
    html = html.replace(/(acct:[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/gi, '<span style="font-family:monospace; color:#6f42c1;">$1</span>');

    // 19. Zeilenumbrüche beibehalten (und Absicherung für echte Leerzeilen)
    html = html.replace(/\n/g, '<br>');
    html = html.replace(/(?:^|<br>)\s*---\s*(?=$|<br>)/g, '<hr>');
    html = html.replace(/(<\/tr>|<table[^>]*>|<\/table>|<\/ul>|<\/ol>|<\/li>|<hr>)\s*<br>/g, '$1');
    html = html.replace(/<br>\s*(<tr>|<table[^>]*>|<\/table>|<ul[^>]*>|<ol[^>]*>|<li[^>]*>|<hr>)/g, '$1');

    return html;
}
