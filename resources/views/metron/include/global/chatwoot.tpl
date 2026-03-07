<script>
    (function () {
        var chatwootBaseUrl = "{$metron['chatwoot_base_url']|escape:"javascript"}".replace(/\/+$/, '');
        var chatwootWebsiteToken = "{$metron['chatwoot_website_token']|escape:"javascript"}";
        var chatwootBooted = false;
        var chatwootSynced = false;

        if (chatwootBaseUrl === '' || chatwootWebsiteToken === '') {
            return;
        }

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
            bootChatwoot();
        } else if (window.addEventListener) {
            window.addEventListener('load', bootChatwoot);
        } else if (window.attachEvent) {
            window.attachEvent('onload', bootChatwoot);
        }
    })();
</script>
