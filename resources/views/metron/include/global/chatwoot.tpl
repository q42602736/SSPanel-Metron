<script>
    (function () {
        var chatwootBaseUrl = "{$metron['chatwoot_base_url']|escape:"javascript"}".replace(/\/+$/, '');
        var chatwootWebsiteToken = "{$metron['chatwoot_website_token']|escape:"javascript"}";
        var chatwootLauncherMode = "{$metron['chatwoot_launcher_mode']|default:'official'|escape:"javascript"}";
        var chatwootBooted = false;
        var chatwootSynced = false;
        var customLauncherButton = null;
        var customLauncherAvatar = null;
        var customLauncherFallback = null;
        var customLauncherRequested = false;
        var customLauncherMeta = {
            avatar_url: '',
            name: '在线客服'
        };
        var isCustomLauncherMode = chatwootLauncherMode === 'custom_avatar';

        if (chatwootBaseUrl === '' || chatwootWebsiteToken === '') {
            return;
        }

        var ensureChatwootSettings = function () {
            if (isCustomLauncherMode !== true) {
                return;
            }

            if (!window.chatwootSettings || Object.prototype.toString.call(window.chatwootSettings) !== '[object Object]') {
                window.chatwootSettings = {};
            }

            window.chatwootSettings.hideMessageBubble = true;
        };

        var ensureCustomLauncherStyle = function () {
            if (isCustomLauncherMode !== true || document.getElementById('chatwoot-custom-launcher-style')) {
                return;
            }

            var style = document.createElement('style');
            style.id = 'chatwoot-custom-launcher-style';
            style.type = 'text/css';
            style.appendChild(document.createTextNode(''
                + '#chatwoot-custom-launcher{position:fixed;right:24px;bottom:24px;width:64px;height:64px;padding:0;border:0;border-radius:9999px;background:#ffffff;box-shadow:0 10px 30px rgba(15,23,42,.22);overflow:hidden;cursor:pointer;z-index:2147483000;display:flex;align-items:center;justify-content:center;transition:transform .2s ease,box-shadow .2s ease;}'
                + '#chatwoot-custom-launcher:hover{transform:translateY(-2px);box-shadow:0 14px 36px rgba(15,23,42,.26);}'
                + '#chatwoot-custom-launcher:focus{outline:none;box-shadow:0 0 0 3px rgba(59,130,246,.24),0 14px 36px rgba(15,23,42,.26);}'
                + '#chatwoot-custom-launcher img{width:100%;height:100%;object-fit:cover;display:none;}'
                + '#chatwoot-custom-launcher .chatwoot-custom-launcher-fallback{width:100%;height:100%;display:flex;align-items:center;justify-content:center;background:linear-gradient(135deg,#1d9bf0 0%,#0b7ad1 100%);color:#ffffff;}'
                + '#chatwoot-custom-launcher .chatwoot-custom-launcher-fallback svg{width:30px;height:30px;display:block;}'
                + '@media (max-width: 767px){#chatwoot-custom-launcher{right:16px;bottom:16px;width:56px;height:56px;}}'
            ));
            document.head.appendChild(style);
        };

        var updateCustomLauncher = function () {
            if (customLauncherButton === null) {
                return;
            }

            var launcherName = (customLauncherMeta.name || '在线客服').replace(/\s+/g, ' ').trim();
            customLauncherButton.setAttribute('aria-label', '打开' + launcherName);
            customLauncherButton.setAttribute('title', launcherName);

            if (customLauncherMeta.avatar_url !== '') {
                customLauncherAvatar.onload = function () {
                    customLauncherAvatar.style.display = 'block';
                    customLauncherFallback.style.display = 'none';
                };
                customLauncherAvatar.onerror = function () {
                    customLauncherAvatar.style.display = 'none';
                    customLauncherFallback.style.display = 'flex';
                };

                if (customLauncherAvatar.getAttribute('src') !== customLauncherMeta.avatar_url) {
                    customLauncherAvatar.setAttribute('src', customLauncherMeta.avatar_url);
                } else if (customLauncherAvatar.complete === true) {
                    customLauncherAvatar.style.display = 'block';
                    customLauncherFallback.style.display = 'none';
                }
                return;
            }

            customLauncherAvatar.removeAttribute('src');
            customLauncherAvatar.style.display = 'none';
            customLauncherFallback.style.display = 'flex';
        };

        var openChatwootWidget = function (attemptCount) {
            attemptCount = attemptCount || 0;
            bootChatwoot();

            if (!window.$chatwoot) {
                if (attemptCount >= 20) {
                    return;
                }

                window.setTimeout(function () {
                    openChatwootWidget(attemptCount + 1);
                }, 300);
                return;
            }

            if (typeof window.$chatwoot.toggle === 'function') {
                window.$chatwoot.toggle('open');
            }
        };

        var ensureCustomLauncher = function () {
            if (isCustomLauncherMode !== true || customLauncherButton !== null) {
                return;
            }

            ensureCustomLauncherStyle();

            customLauncherButton = document.createElement('button');
            customLauncherButton.type = 'button';
            customLauncherButton.id = 'chatwoot-custom-launcher';

            customLauncherAvatar = document.createElement('img');
            customLauncherAvatar.alt = '在线客服头像';
            customLauncherAvatar.referrerPolicy = 'no-referrer';

            customLauncherFallback = document.createElement('span');
            customLauncherFallback.className = 'chatwoot-custom-launcher-fallback';
            customLauncherFallback.innerHTML = '<svg viewBox="0 0 24 24" aria-hidden="true"><path fill="currentColor" d="M12 3C6.477 3 2 7.031 2 12c0 2.285.947 4.369 2.511 5.954L4 22l4.516-1.899A10.88 10.88 0 0 0 12 21c5.523 0 10-4.031 10-9s-4.477-9-10-9Zm-4 8h8a1 1 0 1 1 0 2H8a1 1 0 1 1 0-2Zm0-3h8a1 1 0 1 1 0 2H8a1 1 0 1 1 0-2Z"></path></svg>';

            customLauncherButton.appendChild(customLauncherAvatar);
            customLauncherButton.appendChild(customLauncherFallback);
            customLauncherButton.addEventListener('click', function () {
                openChatwootWidget(0);
            });
            document.body.appendChild(customLauncherButton);

            updateCustomLauncher();
        };

        var fetchCustomLauncherMeta = function () {
            if (isCustomLauncherMode !== true || customLauncherRequested === true) {
                return;
            }

            customLauncherRequested = true;
            ensureCustomLauncher();

            var request = new XMLHttpRequest();
            request.open('GET', '/chatwoot/launcher', true);
            request.onreadystatechange = function () {
                if (request.readyState !== 4) {
                    return;
                }

                if (request.status < 200 || request.status >= 300) {
                    updateCustomLauncher();
                    return;
                }

                try {
                    var payload = JSON.parse(request.responseText);
                    if (payload && typeof payload === 'object') {
                        if (typeof payload.name === 'string' && payload.name !== '') {
                            customLauncherMeta.name = payload.name;
                        }
                        if (typeof payload.avatar_url === 'string') {
                            customLauncherMeta.avatar_url = payload.avatar_url;
                        }
                    }
                } catch (error) {
                }

                updateCustomLauncher();
            };
            request.send(null);
        };

        var syncChatwootUser = function () {
            if (chatwootSynced === true) {
                return;
            }

            if (!window.$chatwoot || typeof window.$chatwoot.setUser !== 'function' || typeof window.$chatwoot.setCustomAttributes !== 'function') {
                return;
            }

            chatwootSynced = true;

            {if $user->isLogin}
            var userLevelName = "{$user->class|escape:"javascript"}";
            {if isset($metron['user_level'][$user->class])}
            userLevelName = "{$metron['user_level'][$user->class]|escape:"javascript"}";
            {/if}

            var contactAttributes = {
                "class": userLevelName,
                "class_expire": "{$user->class_expire|escape:"javascript"}",
                "money": "{$user->money|escape:"javascript"}",
                "unused_traffic": "{$user->unusedTraffic()|escape:"javascript"}",
            };

            window.$chatwoot.setUser("{$user->uuid|escape:"javascript"}", {
                email: "{$user->email|escape:"javascript"}",
                name: "{$user->user_name|escape:"javascript"}",
            });

            window.$chatwoot.setCustomAttributes(contactAttributes);
            window.setTimeout(function () {
                if (window.$chatwoot && typeof window.$chatwoot.setCustomAttributes === 'function') {
                    window.$chatwoot.setCustomAttributes(contactAttributes);
                }
            }, 1000);
            {/if}
        };

        if (window.addEventListener) {
            window.addEventListener('chatwoot:ready', syncChatwootUser);
        } else if (window.attachEvent) {
            window.attachEvent('chatwoot:ready', syncChatwootUser);
        }

        var bootChatwoot = function () {
            if (chatwootBooted === true) {
                return;
            }

            chatwootBooted = true;
            ensureChatwootSettings();

            var script = document.createElement('script');
            script.async = true;
            script.defer = true;
            script.src = chatwootBaseUrl + '/packs/js/sdk.js';
            script.onload = function () {
                if (!window.chatwootSDK || typeof window.chatwootSDK.run !== 'function') {
                    return;
                }

                window.chatwootSDK.run({
                    websiteToken: chatwootWebsiteToken,
                    baseUrl: chatwootBaseUrl,
                });
            };
            document.head.appendChild(script);
        };

        if (document.readyState === 'complete') {
            if (isCustomLauncherMode === true) {
                ensureCustomLauncher();
                fetchCustomLauncherMeta();
            }
            bootChatwoot();
        } else if (window.addEventListener) {
            window.addEventListener('load', function () {
                if (isCustomLauncherMode === true) {
                    ensureCustomLauncher();
                    fetchCustomLauncherMeta();
                }
                bootChatwoot();
            });
        } else if (window.attachEvent) {
            window.attachEvent('onload', function () {
                if (isCustomLauncherMode === true) {
                    ensureCustomLauncher();
                    fetchCustomLauncherMeta();
                }
                bootChatwoot();
            });
        }
    })();
</script>
