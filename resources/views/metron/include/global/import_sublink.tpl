        <script>
            function importSublink(client) {
            if (client == 'ssr') {
                index.oneclickImport('ssr', '{$subInfo["ssr"]}');
            };
            if (client == 'clash') {
                index.oneclickImport('clash','{$subInfo["clash"]}')
            };
            if (client == 'singbox') {
                window.location.href = 'sing-box://import-remote-profile?url=' + encodeURIComponent('{$subInfo["singbox"]}') + "#" + '{$config["appName"]}';
            };
            if (client == 'shadowrocket') {
                index.oneclickImport('shadowrocket','{$subInfo["shadowrocket"]}')
            };
            if (client == 'quantumult') {
                index.oneclickImport('quantumult','{$subInfo["ssr"]}')
            };
            if (client == 'quantumult_v2') {
                index.oneclickImport('quantumult_v2','{$subInfo["quantumult_v2"]}')
            };
            if (client == 'quantumultx') {
                var qxUrl = '{$subInfo["quantumultx"]|escape:"javascript"}';
                var qxTag = '{$config["appName"]|escape:"javascript"}';
                var qxResource = qxUrl + ', tag=' + qxTag + ', update-interval=172800, opt-parser=false, enabled=true';
                var qxJson = JSON.stringify({
                    "server_remote": [qxResource]
                });
                window.location.href = 'quantumult-x:///add-resource?remote-resource=' + encodeURIComponent(qxJson);
            };
            if (client == 'stash') {
                location.href = "stash://install-config?url=" + encodeURIComponent('{$subInfo["stash"]}') + "&name=" + '{$config["appName"]}'
            };
            }
            function qrcodeSublink(client) {
                if (client == 'shadowrocket') {
                    index.qrcodeImport('shadowrocket', '{$subInfo["shadowrocket"]}');
                }
                if (client == 'clash') {
                    // 直接实现 Clash 二维码功能，不依赖 metron.js
                    $.getScript(ASSETS_URL + '/plugins/jQuery-qrcode/jquery.qrcode.min.js', function() {
                        var clashUrl = '{$subInfo["clash"]}';
                        $('#qrcode-sublink-content').html('<div class="text-center"><p>使用 Clash 客户端扫描</p><div align="center" id="qrcode" style="padding-top:10px;"></div></div>');
                        $('#qrcode').qrcode({
                            text: 'clash://install-config?url=' + encodeURIComponent(clashUrl)
                        });
                        $('#qrcode-sublink-modal').modal('show');
                    });
                }
            }
        </script>
