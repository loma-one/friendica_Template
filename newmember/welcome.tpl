{{*
  * Copyright (C) 2010-2024, the Friendica project
  * SPDX-FileCopyrightText: 2010-2024 the Friendica project
  *
  * SPDX-License-Identifier: AGPL-3.0-or-later
  *}}
{{if $welcome}}
<style>
    :root { --f-blue: #5385c1; --f-blue-l: rgba(83, 133, 193, 0.1); --f-blue-h: #426fa3; }

    .welcome-modal-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.85); backdrop-filter: blur(10px);
        display: flex; align-items: center; justify-content: center;
        z-index: 10000;
    }

    .welcome-modal-content {
        background: var(--background-color, #fff); color: var(--font-color, #333);
        width: 95%; max-width: 1100px;
        max-height: 96vh; border-radius: 24px;
        padding: 1.5rem 3rem;
        position: relative; overflow-y: auto;
        box-shadow: 0 30px 60px rgba(0,0,0,0.6); border: 1px solid rgba(128,128,128,0.2);
    }

    .welcome-header { text-align: center; margin-bottom: 1rem; }
    .welcome-header h1 { font-size: 3rem; font-weight: 800; color: var(--f-blue); line-height: 1.1; margin-bottom: .5rem; }
    .onboarding-progress { width: 100%; height: 8px; background: rgba(128,128,128,0.1); border-radius: 4px; margin: 1rem 0; overflow: hidden; }
    .progress-fill { width: 100%; height: 100%; background: var(--f-blue); }

    .welcome-section-title { border-bottom: 3px solid var(--f-blue-l); padding-bottom: .3rem; margin: 1.5rem 0 1rem; font-size: 1.4rem; text-transform: uppercase; letter-spacing: 2px; font-weight: 700; color: var(--f-blue); }

    .welcome-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; }

    .welcome-card { background: rgba(128,128,128,0.05); border: 1px solid rgba(128,128,128,0.1); border-radius: 20px; padding: 1.5rem; display: flex; flex-direction: column; align-items: center; text-align: center; }
    .welcome-card i.fa-big { font-size: 3.5rem; color: var(--f-blue); margin-bottom: 1rem; }
    .welcome-card h4 { font-size: 1.6rem; margin: 0.8rem 0; font-weight: 700; }
    .welcome-card p { font-size: 1.2rem; line-height: 1.4; margin-bottom: 1.5rem; opacity: 0.9; flex-grow: 1; }

    .app-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; width: 100%; margin-top: 1rem; }
    .app-card { background: rgba(255,255,255,0.03); border-radius: 16px; padding: 0.8rem; border: 1px solid rgba(128,128,128,0.15); }
    .qr-code { width: 100%; max-width: 95px; background: #fff; padding: 6px; border-radius: 8px; margin: 0.6rem auto; display: block; }
    .app-name { font-size: 1.1rem; font-weight: 700; display: block; min-height: 1.2rem; }

    .hashtag-cloud { display: flex; flex-wrap: wrap; gap: .8rem; justify-content: center; }
    .hashtag-tag { background: var(--f-blue-l); border: 2px solid var(--f-blue); color: var(--f-blue) !important; padding: .6rem 1.2rem; border-radius: 30px; font-weight: 700; font-size: 1.5rem; text-decoration: none; }

    .welcome-btn { display: inline-block; background: var(--f-blue); color: #fff !important; padding: 1rem 2rem; border-radius: 12px; text-decoration: none; font-weight: 700; font-size: 1.3rem; cursor: pointer; border: none; width: 100%; }
    .welcome-btn-success { background: #27ae60; padding: 1.2rem 3.5rem; font-size: 1.5rem; transition: .3s; width: auto; }
    .welcome-btn-success:hover { transform: scale(1.05); }

    .welcome-footer { margin-top: 2rem; padding-bottom: 1rem; text-align: center; }

    @media (max-width: 950px) { .welcome-grid { grid-template-columns: 1fr; } .app-grid { grid-template-columns: repeat(2, 1fr); } }
</style>

<div id="welcome-overlay" class="welcome-modal-overlay">
    <div class="welcome-modal-content">
        <header class="welcome-header">
            <h1>{{$welcome nofilter}}</h1>
            <p style="font-size: 1.4rem; margin: 0;">{{$description nofilter}}</p>
            <div class="onboarding-progress"><div class="progress-fill"></div></div>
        </header>

        <h3 class="welcome-section-title">1. Mobile Apps nutzen</h3>
        <div class="welcome-card" style="width:100%">
            <p>Servernamen für die App: <strong>{{$baseurl}}</strong>. <br>Login <strong>Name oder Handle & Passwort</strong> von diesem Server</p>
            <div class="app-grid">
                <div class="app-card">
                    <span class="app-name">Raccoon (Android)</span>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=https://play.google.com/store/apps/details?id=com.livefast.eattrash.raccoonforfriendica" class="qr-code">
                </div>
                <div class="app-card">
                    <span class="app-name">Tusky (Android)</span>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=https://tusky.app" class="qr-code">
                </div>
                <div class="app-card">
                    <span class="app-name">Mona (iOS)</span>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=https://apps.apple.com/app/mona-classic/id1659154653" class="qr-code">
                </div>
                <div class="app-card">
                    <span class="app-name">IceCubes (iOS)</span>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=https://apps.apple.com/app/ice-cubes-for-mastodon/id6444915884" class="qr-code">
                </div>
            </div>
        </div>

        <h3 class="welcome-section-title">2. Themen finden</h3>
        <div class="welcome-card" style="width:100%">
            <p>Suche Interesse Themen über Hashtags und <strong>"Speicher"</strong>: sie für deine Timeline</p>
            <div class="hashtag-cloud">
                <a href="{{$baseurl}}/search?q=%23neuhier" class="hashtag-tag" target="newmember">#neuhier</a>
                <a href="{{$baseurl}}/search?q=%23fediverse" class="hashtag-tag" target="newmember">#fediverse</a>
                <a href="{{$baseurl}}/search?q=%23fedilz" class="hashtag-tag" target="newmember">#fedilz</a>
                <a href="{{$baseurl}}/search?q=%23diday" class="hashtag-tag" target="newmember">#diday</a>
                <a href="{{$baseurl}}/search?q=%23coffee" class="hashtag-tag" target="newmember">#coffee</a>
                <a href="{{$baseurl}}/search?q=%23streetart" class="hashtag-tag" target="newmember">#streetart</a>
                <a href="{{$baseurl}}/search?q=%23signal" class="hashtag-tag" target="newmember">#signal</a>
                <a href="{{$baseurl}}/search?q=%23foto" class="hashtag-tag" target="newmember">#foto</a>
            </div>
        </div>

        <h3 class="welcome-section-title">3. Vernetzung & Dein Profil</h3>
        <div class="welcome-grid">
           <div class="welcome-card">
                <i class="fa fa-share-alt fa-big" aria-hidden="true"></i>
                <h4>Netzwerke</h4>
                <p>Verbinde dein Konto mit Bluesky, Tumble, etc.</p>
                <a class="welcome-btn" target="newmember" href="{{$baseurl}}/settings/connectors">Verbinden</a>
            </div>
            <div class="welcome-card">
                <i class="fa fa-camera fa-big" aria-hidden="true"></i>
                <h4>Profilbild</h4>
                <p>Verpasse deinem Profil mehr Ausdruck.</p>
                <a class="welcome-btn" target="newmember" href="{{$baseurl}}/settings/profile/photo">Foto hochladen</a>
            </div>
            <div class="welcome-card">
                <i class="fa fa-cog fa-big" aria-hidden="true"></i>
                <h4>Konto</h4>
                <p>Passe deine Kontoeinstellungen an.</p>
                <a class="welcome-btn" target="newmember" href="{{$baseurl}}/settings">Einstellungen</a>
            </div>
        </div>

        <div class="welcome-footer">
            <button class="welcome-btn welcome-btn-success" onclick="finishOnboarding()">
                <i class="fa fa-rocket" aria-hidden="true"></i> Ab zu den Feeds in deiner Sprache
            </button>
        </div>
    </div>
</div>

<script>
    function finishOnboarding() {
        window.location.href = "{{$baseurl}}/network?channel=language";
    }
</script>
{{/if}}
