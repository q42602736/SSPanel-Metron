{include file='admin/main.tpl'}
{$methods = [
'none',
'aes-128-ctr',
'aes-192-ctr',
'aes-256-ctr',
'aes-128-cfb',
'aes-192-cfb',
'aes-256-cfb',
'aes-128-cfb8',
'aes-192-cfb8',
'aes-256-cfb8',
'aes-128-gcm',
'aes-256-gcm',
'rc4',
'rc4-md5',
'rc4-md5-6',
'salsa20',
'chacha20',
'xsalsa20',
'xchacha20',
'chacha20-ietf',
'2022-blake3-aes-128-gcm',
'2022-blake3-aes-256-gcm',
'2022-blake3-chacha20-poly1305'
]}
{$protocols = [
'origin',
'verify_deflate',
'auth_sha1_v4',
'auth_aes128_md5',
'auth_aes128_sha1',
'auth_chain_a',
'auth_chain_b',
'auth_chain_c',
'auth_chain_d',
'auth_chain_e',
'auth_chain_f',
'auth_akarin_rand',
'auth_akarin_spec_a'
]}
{$obfss = [
'plain',
'http_simple',
'http_post',
'random_head',
'tls1.2_ticket_auth',
'tls1.2_ticket_fastauth'
]}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">添加节点</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <section class="content-inner margin-top-no">
                <form id="main_form">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-main">
                                    <div class="card-inner">
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="name">节点名称</label>
                                            <input class="form-control maxwidth-edit" id="name" type="text" name="name">
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="server">节点地址</label>
                                            <input class="form-control maxwidth-edit" id="server" type="text" name="server">
                                            
                                            <!-- Shadowsocks2022 提示 -->
                                            <div id="server_hint_ss2022" style="display: none;">
                                                <p class="form-control-guide">
                                                    <i class="material-icons">info</i>格式：8.8.8.8;10086;in.nodeserver.com;443
                                                </p>
                                                <p class="form-control-guide">
                                                    <i class="material-icons">info</i>落地IP或域名;落地端口;订阅下发地址;订阅下发端口
                                                </p>
                                            </div>
                                            
                                            <!-- Reality 提示 -->
                                            <div id="server_hint_reality" style="display: none;">
                                                <p class="form-control-guide">
                                                    <i class="material-icons">info</i>格式：example.com;443;0;tcp;;security=reality|privateKey=your_private_key|publicKey=your_public_key|shortId=0123456789abcdef|serverName=www.amazon.com|fp=chrome|flow=xtls-rprx-vision
                                                </p>
                                            </div>
                                            
                                            <!-- AnyTLS 提示 -->
                                            <div id="server_hint_anytls" style="display: none;">
                                                <p class="form-control-guide">
                                                    <i class="material-icons">info</i>格式：example.com;port=443&server_name=example.com&insecure=0
                                                </p>
                                                <p class="form-control-guide">
                                                    <i class="material-icons">info</i>填充方案将自动添加到配置中
                                                </p>
                                            </div>
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="server">节点IP</label>
                                            <input class="form-control maxwidth-edit" id="node_ip" name="node_ip" type="text">
                                            <p class="form-control-guide"><i class="material-icons">info</i>如果“节点地址”填写为域名，则此处的值会被忽视
                                            </p>
                                        </div>
                                        <!--
                                        <div class="form-group form-group-label" hidden="hidden">
                                            <label class="floating-label" for="method">加密方式</label>
                                            <input class="form-control maxwidth-edit" id="method" type="text" name="method"
                                                   value="aes-256-cfb">
                                        </div> -->

                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="rate">流量比例</label>
                                            <input class="form-control maxwidth-edit" id="rate" type="text" name="rate"
                                                   value="1">
                                        </div>

                                        <div class="form-group form-group-label" hidden="hidden">
                                            <div class="checkbox switch">
                                                <label for="custom_method">
                                                    <input class="access-hide" id="custom_method" type="checkbox"
                                                           name="custom_method" checked="checked" disabled><span
                                                            class="switch-toggle"></span>自定义加密
                                                </label>
                                            </div>
                                        </div>

                                        <div class="form-group form-group-label" hidden="hidden">
                                            <div class="checkbox switch">
                                                <label for="custom_rss">
                                                    <input class="access-hide" id="custom_rss" type="checkbox" name="custom_rss"
                                                           checked="checked" disabled><span class="switch-toggle"></span>自定义协议&混淆
                                                </label>
                                            </div>
                                        </div>

                                        <div class="form-group form-group-label">
                                            <label for="mu_only">
                                                <label class="floating-label" for="sort">单端口多用户启用</label>
                                                <select id="mu_only" class="form-control maxwidth-edit" name="is_multi_user">
                                                    <option value="-1">只启用普通端口</option>
                                                    <option value="0">单端口多用户与普通端口并存</option>
                                                    <option value="1">只启用单端口多用户</option>
                                                </select>
                                            </label>
                                        </div>


                                    </div>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-main">
                                    <div class="card-inner">
                                        <p class="form-control-guide"><i class="material-icons">info</i>当设置为"只启用单端口多用户", 并且多用户端口不为 0 时, 下发该节点自定义配置</p>
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="port">多用户端口</label>
                                            <input class="form-control maxwidth-edit" id="port" name="port" type="text" value="0">
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="passwd">节点密码</label>
                                            <input class="form-control maxwidth-edit" id="passwd" name="passwd" type="text" value="MetronTheme">
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label for="method">
                                                <label class="floating-label" for="method">加密方式</label>
                                                <select id="method" class="form-control maxwidth-edit" name="method">
                                                    {foreach $methods as $method}
                                                        <option value="{$method}">{$method}</option>
                                                    {/foreach}
                                                </select>
                                            </label>
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label for="protocol">
                                                <label class="floating-label" for="protocol">协议</label>
                                                <select id="protocol" class="form-control maxwidth-edit" name="protocol">
                                                    {foreach $protocols as $protocol}
                                                        <option value="{$protocol}">{$protocol}</option>
                                                    {/foreach}
                                                </select>
                                            </label>
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label for="obfs">
                                                <label class="floating-label" for="obfs">混淆方式</label>
                                                <select id="obfs" class="form-control maxwidth-edit" name="obfs">
                                                    {foreach $obfss as $obfs}
                                                        <option value="{$obfs}">{$obfs}</option>
                                                    {/foreach}
                                                </select>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-main">
                                    <div class="card-inner">
                                        <div class="form-group form-group-label">
                                            <div class="checkbox switch">
                                                <label for="type">
                                                    <input checked class="access-hide" id="type" type="checkbox"
                                                           name="type"><span class="switch-toggle"></span>是否显示
                                                </label>
                                            </div>
                                        </div>


                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="status">节点状态</label>
                                            <input class="form-control maxwidth-edit" id="status" type="text" name="status"
                                                   value="可用">
                                        </div>

                                        <div class="form-group form-group-label">
                                            <div class="form-group form-group-label">
                                                <label class="floating-label" for="sort">节点类型</label>
                                                <select id="sort" class="form-control maxwidth-edit" name="sort">
                                                    <option value="0">Shadowsocks</option>
                                                    <option value="1">Shadowsocks 2022</option>
                                                    <option value="9">Shadowsocks 单端口多用户</option>
                                                    <option value="11">V2Ray</option>
                                                    <option value="14">Trojan</option>
                                                    <option value="15">V2Ray-VLESS</option>
                                                    <option value="16">V2Ray-VLESS-Reality</option>
                                                    <option value="17">Hysteria2</option>
                                                    <option value="18">AnyTLS</option>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- AnyTLS 填充方案选择 -->
                                        <div class="form-group form-group-label" id="anytls_padding_select" style="display: none;">
                                            <label class="floating-label" for="padding_preset">填充方案</label>
                                            <select id="padding_preset" class="form-control maxwidth-edit" name="padding_preset">
                                                <option value="">不填充（使用默认）</option>
                                                <option value="light">轻量级 - 低带宽开销（~400字节）</option>
                                                <option value="standard">标准 - 平衡性能和安全（~4KB，推荐）</option>
                                                <option value="aggressive">激进 - 高安全性（~12KB）</option>
                                                <option value="custom">自定义</option>
                                            </select>
                                            <p class="form-control-guide">
                                                <i class="material-icons">info</i>填充方案用于对抗流量指纹识别，提高连接安全性
                                            </p>
                                        </div>

                                        <!-- 自定义填充方案输入 -->
                                        <div class="form-group" id="custom_padding_input" style="display: none;">
                                            <label for="custom_padding_scheme">自定义填充方案</label>
                                            <textarea class="form-control maxwidth-edit" id="custom_padding_scheme" rows="6" placeholder='["stop=8","0=30-30","1=100-400","2=500-1000"]' style="opacity: 1 !important; color: #000 !important; border-radius: 2px !important;"></textarea>
                                            <p class="form-control-guide">
                                                <i class="material-icons">info</i>格式：JSON 数组，例如 ["stop=8","0=30-30","1=100-400"]
                                            </p>
                                            <p class="form-control-guide">
                                                <i class="material-icons">info</i>规则说明：stop=8 表示在第8个包后停止，0=30-30 表示第1个包填充30字节
                                            </p>
                                        </div>

                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="info">节点描述</label>
                                            <input class="form-control maxwidth-edit" id="info" type="text" name="info"
                                                   value="无描述">
                                        </div>

                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="class">节点等级</label>
                                            <input class="form-control maxwidth-edit" id="class" type="text" value="0"
                                                   name="class">
                                            <p class="form-control-guide"><i class="material-icons">info</i>不分级请填0，分级填写相应数字</p>
                                        </div>


                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="group">节点群组</label>
                                            <input class="form-control maxwidth-edit" id="group" type="text" value="0"
                                                   name="group">
                                            <p class="form-control-guide"><i class="material-icons">info</i>分组为数字，不分组请填0</p>
                                        </div>


                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="node_bandwidth_limit">节点流量上限（GB）</label>
                                            <input class="form-control maxwidth-edit" id="node_bandwidth_limit" type="text"
                                                   value="0" name="node_bandwidth_limit">
                                            <p class="form-control-guide"><i class="material-icons">info</i>不设上限请填0</p>
                                        </div>

                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="bandwidthlimit_resetday">节点流量上限清空日</label>
                                            <input class="form-control maxwidth-edit" id="bandwidthlimit_resetday" type="text"
                                                   value="1" name="bandwidthlimit_resetday">
                                        </div>

                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="node_speedlimit">节点限速（Mbps）</label>
                                            <input class="form-control maxwidth-edit" id="node_speedlimit" type="text" value="0"
                                                   name="node_speedlimit">
                                            <p class="form-control-guide"><i class="material-icons">info</i>不限速填0，对于每个用户端口生效</p>
                                        </div>

                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="node_speedlimit">节点排序</label>
                                            <input class="form-control maxwidth-edit" id="node_sort" type="text" value="0"
                                                   name="node_sort">
                                            <p class="form-control-guide"><i class="material-icons">info</i>数字越大越靠前</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    <!-- 隐藏字段存储最终的填充方案 -->
                    <input type="hidden" id="padding_scheme_value" name="padding_scheme">
                    
                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">

                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-10 col-md-push-1">
                                            <button id="submit" type="submit"
                                                    class="btn btn-block btn-brand waves-attach waves-light">添加
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                {include file='dialog.tpl'}


        </div>


    </div>
</main>

{include file='admin/footer.tpl'}

<script>
    {literal}
    
    // 预设方案定义
    const paddingPresets = {
        light: [
            "stop=4",
            "0=10-50",
            "1=50-100",
            "2=100-200",
            "3=100-200"
        ],
        standard: [
            "stop=8",
            "0=30-30",
            "1=100-400",
            "2=400-500,c,500-1000,c,500-1000,c,500-1000,c,500-1000",
            "3=9-9,500-1000",
            "4=500-1000",
            "5=500-1000",
            "6=500-1000",
            "7=500-1000"
        ],
        aggressive: [
            "stop=16",
            "0=50-100",
            "1=200-500",
            "2=500-1500,c,1000-2000,c,1000-2000",
            "3=100-500,c,500-1000",
            "4=500-1000",
            "5=500-1000",
            "6=500-1000",
            "7=500-1000",
            "8=300-800",
            "9=300-800",
            "10=300-800",
            "11=300-800",
            "12=300-800",
            "13=300-800",
            "14=300-800",
            "15=300-800"
        ]
    };
    
    // 监听节点类型变化
    $('#sort').on('change', function() {
        const sortValue = $(this).val();
        
        // 隐藏所有提示
        $('#server_hint_ss2022, #server_hint_reality, #server_hint_anytls').hide();
        
        // 显示/隐藏 AnyTLS 填充方案选择
        if (sortValue === '18') {
            $('#anytls_padding_select').slideDown();
            $('#server_hint_anytls').show();
        } else {
            $('#anytls_padding_select').slideUp();
            $('#padding_scheme_value').val('');
            
            // 显示对应的提示
            if (sortValue === '1') {
                $('#server_hint_ss2022').show();
            } else if (sortValue === '16') {
                $('#server_hint_reality').show();
            }
        }
    });
    
    // 监听填充方案选择变化
    $('#padding_preset').on('change', function() {
        const preset = $(this).val();
        
        if (preset === 'custom') {
            // 显示自定义输入框
            $('#custom_padding_input').slideDown();
            $('#padding_scheme_value').val('');
        } else {
            // 隐藏自定义输入框
            $('#custom_padding_input').slideUp();
            
            if (preset === '') {
                // 不填充
                $('#padding_scheme_value').val('');
            } else {
                // 使用预设方案
                const scheme = paddingPresets[preset];
                $('#padding_scheme_value').val(JSON.stringify(scheme));
            }
        }
    });
    
    // 监听自定义填充方案输入
    $('#custom_padding_scheme').on('input', function() {
        const customValue = $(this).val().trim();
        
        if (customValue) {
            try {
                // 验证 JSON 格式
                const parsed = JSON.parse(customValue);
                if (Array.isArray(parsed)) {
                    $('#padding_scheme_value').val(customValue);
                    // 移除错误提示
                    $(this).removeClass('is-invalid');
                } else {
                    $(this).addClass('is-invalid');
                }
            } catch (e) {
                // JSON 格式错误
                $(this).addClass('is-invalid');
            }
        } else {
            $('#padding_scheme_value').val('');
            $(this).removeClass('is-invalid');
        }
    });
    
    // 页面加载时初始化
    $(document).ready(function() {
        const currentSort = $('#sort').val();
        if (currentSort === '18') {
            $('#anytls_padding_select').show();
            $('#server_hint_anytls').show();
        }
    });
    
    $('#main_form').validate({
        rules: {
            name: {required: true},
            method: {required: true},
            rate: {required: true},
            info: {required: true},
            group: {required: true},
            status: {required: true},
            node_speedlimit: {required: true},
            sort: {required: true},
            node_bandwidth_limit: {required: true},
            bandwidthlimit_resetday: {required: true}
        },

        submitHandler: () => {
            if ($$.getElementById('custom_method').checked) {
                var custom_method = 1;
            } else {
                var custom_method = 0;
            }

            if ($$.getElementById('type').checked) {
                var type = 1;
            } else {
                var type = 0;
            }
            {/literal}
            if ($$.getElementById('custom_rss').checked) {
                var custom_rss = 1;
            } else {
                var custom_rss = 0;
            }
            
            // 处理 AnyTLS 填充方案
            let serverValue = $$getValue('server');
            const sortValue = $$getValue('sort');
            const paddingScheme = $('#padding_scheme_value').val();
            
            // 如果是 AnyTLS 且有填充方案，添加到 server 字段
            if (sortValue === '18' && paddingScheme) {
                const serverParts = serverValue.split(';');
                const host = serverParts[0];
                let params = '';
                
                if (serverParts.length > 1) {
                    params = serverParts[1];
                }
                
                // 添加 padding_scheme 参数
                if (params) {
                    params += '&padding_scheme=' + encodeURIComponent(paddingScheme);
                } else {
                    params = 'padding_scheme=' + encodeURIComponent(paddingScheme);
                }
                
                serverValue = host + ';' + params;
            }

            $.ajax({
                type: "POST",
                url: "/admin/node",
                dataType: "json",
                data: {
                    name: $$getValue('name'),
                    server: serverValue,
                    node_ip: $$getValue('node_ip'),
                    method: $$getValue('method'),
                    port: $$getValue("port"),
                    obfs: $$getValue("obfs"),
                    protocol: $$getValue("protocol"),
                    passwd: $$getValue("passwd"),
                    custom_method,
                    rate: $$getValue('rate'),
                    info: $$getValue('info'),
                    type,
                    group: $$getValue('group'),
                    status: $$getValue('status'),
                    node_speedlimit: $$getValue('node_speedlimit'),
                    node_sort: $$getValue('node_sort'),
                    sort: $$getValue('sort'),
                    class: $$getValue('class'),
                    node_bandwidth_limit: $$getValue('node_bandwidth_limit'),
                    bandwidthlimit_resetday: $$getValue('bandwidthlimit_resetday'),
                    custom_rss,
                    mu_only: $$getValue('mu_only')
                },
                success: data => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                    }`;
                }
            });
        }
    });

</script>
