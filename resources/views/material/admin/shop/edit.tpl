{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">编辑商品</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <section class="content-inner margin-top-no">

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="name">名称</label>
                                <input class="form-control maxwidth-edit" id="name" type="text" value="{$shop->name}">
                            </div>


                            <div class="form-group form-group-label">
                                <label class="floating-label" for="price">价格</label>
                                <input class="form-control maxwidth-edit" id="price" type="text" value="{$shop->price}">
                            </div>

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="auto_renew">自动续订天数</label>
                                <input class="form-control maxwidth-edit" id="auto_renew" type="text"
                                       value="{$shop->auto_renew}">
                                <p class="form-control-guide"><i class="material-icons">info</i>0为不允许自动续订，其他为到了那么多天之后就会自动从用户的账户上划钱抵扣
                                </p>
                            </div>


                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="bandwidth">流量（GB）</label>
                                <input class="form-control maxwidth-edit" id="bandwidth" type="text"
                                       value="{$shop->bandwidth()}">
                            </div>


                            <div class="form-group form-group-label">
                                <div class="checkbox switch">
                                    <label for="auto_reset_bandwidth">
                                        <input {if $shop->auto_reset_bandwidth==1}checked{/if} class="access-hide"
                                               id="auto_reset_bandwidth" type="checkbox"><span
                                                class="switch-toggle"></span>续费时自动重置用户流量为上面这个流量值
                                    </label>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            {$content = json_decode($shop->content)}
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="traffic-package-min">最低可购买用户等级</label>
                                <input class="form-control maxwidth-edit" id="traffic-package-min" type="text"
                                value="{if property_exists($content,'traffic_package')}{$content->traffic_package->class->min}{else}0{/if}">
                            </div>

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="traffic-package-max">最高可购买用户等级</label>
                                <input class="form-control maxwidth-edit" id="traffic-package-max" type="text"
                                value="{if property_exists($content,'traffic_package')}{$content->traffic_package->class->max}{else}0{/if}">
                            </div>

                            <div class="form-group form-group-label">
                                <div class="checkbox switch">
                                    <label for="traffic-package-enable">
                                        <input {if $shop->traffic_package()}checked{/if} class="access-hide" id="traffic-package-enable" type="checkbox">
                                        <span class="switch-toggle"></span>是否设置此商品为流量叠加包
                                    </label>
                                    <p class="form-control-guide">
                                        <i class="material-icons">info</i>
                                        设置为流量叠加包后除购买时获得流量外的设置无效
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="expire">账户有效期天数</label>
                                <input class="form-control maxwidth-edit" id="expire" type="text"
                                       value="{$shop->expire()}">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="class">等级</label>
                                <input class="form-control maxwidth-edit" id="class" type="text"
                                       value="{$shop->user_class()}">
                            </div>

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="class_expire">等级有效期天数</label>
                                <input class="form-control maxwidth-edit" id="class_expire" type="text"
                                       value="{$shop->class_expire()}">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="reset_exp">多少天内</label>
                                <input class="form-control maxwidth-edit" id="reset_exp" type="number"
                                       value="{$shop->reset_exp()}">
                            </div>


                            <div class="form-group form-group-label">
                                <label class="floating-label" for="reset">每多少天</label>
                                <input class="form-control maxwidth-edit" id="reset" type="number"
                                       value="{$shop->reset()}">
                            </div>

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="reset_value">重置流量为多少G</label>
                                <input class="form-control maxwidth-edit" id="reset_value" type="number"
                                       value="{$shop->reset_value()}">
                            </div>
                        </div>
                    </div>
                </div>


                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="speedlimit">端口限速</label>
                                <input class="form-control maxwidth-edit" id="speedlimit" type="number"
                                       value="{$shop->speedlimit()}">
                            </div>


                            <div class="form-group form-group-label">
                                <label class="floating-label" for="connector">IP限制</label>
                                <input class="form-control maxwidth-edit" id="connector" type="number"
                                       value="{$shop->connector()}">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="description">服务支持 / 套餐描述</label>
                                <textarea class="form-control maxwidth-edit" id="description" rows="6"
                                          placeholder="支持三种格式：&#10;1. 图标列表：check-全球节点分布;clear-快速客服响应&#10;2. Markdown&#10;3. HTML">{if $shop->description()}{$shop->description()}{else}{foreach $shop->content_extra() as $service}{$service[0]}-{$service[1]}{if $service@last}{else};{/if}{/foreach}{/if}</textarea>
                                <p class="form-control-guide"><i class="material-icons">info</i>
                                    支持三种格式：
                                    <br>① 图标列表：<code>check-全球节点分布;clear-快速客服响应</code>（减号左边为 icon 代号，以 ; 分隔）
                                    <br>② Markdown：直接输入 Markdown 语法
                                    <br>③ HTML：直接输入 HTML 代码
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-10 col-md-push-1">
                                        <button id="submit" type="submit"
                                                class="btn btn-block btn-brand waves-attach waves-light">保存
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}


        </div>


    </div>
</main>

{include file='admin/footer.tpl'}


<script>
    window.addEventListener('load', () => {
        function submit() {
            if ($$.getElementById('auto_reset_bandwidth').checked) {
                var auto_reset_bandwidth = 1;
            } else {
                var auto_reset_bandwidth = 0;
            }

            let contentExtra = $$getValue('description');

            let data = {
                name: $$getValue('name'),
                auto_reset_bandwidth,
                price: $$getValue('price'),
                auto_renew: $$getValue('auto_renew'),
                bandwidth: $$getValue('bandwidth'),
                speedlimit: $$getValue('speedlimit'),
                connector: $$getValue('connector'),
                expire: $$getValue('expire'),
                class: $$getValue('class'),
                class_expire: $$getValue('class_expire'),
                reset: $$getValue('reset'),
                reset_value: $$getValue('reset_value'),
                reset_exp: $$getValue('reset_exp'),
                description: $$getValue('description'),
            }

            if ($$.getElementById('traffic-package-enable').checked) {
                data.traffic_package = {
                    class: {
                        min: $$getValue('traffic-package-min'),
                        max: $$getValue('traffic-package-max')
                    }
                }
            } 

            $.ajax({
                type: "PUT",
                url: "/admin/shop/{$shop->id}",
                dataType: "json",
                data,
                success: data => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/admin/shop'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: jqXHR => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                            }`;
                }
            });
        }

        $("html").keydown(event => {
            if (event.keyCode === 13) {
                login();
            }
        });

        $$.getElementById('submit').addEventListener('click', submit);

    })
</script>
