<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>专用节点 &mdash; {$config["appName"]}</title>
    <style>
        .dedicated-node-footer {
            min-width: 0;
        }

        .dedicated-node-footer-row {
            column-gap: 16px;
            row-gap: 12px;
        }

        .dedicated-node-price {
            flex: 0 0 auto;
        }

        .dedicated-node-status {
            flex: 1 1 240px;
            min-width: 0;
            max-width: 100%;
            white-space: normal;
            overflow-wrap: anywhere;
            line-height: 1.6;
            text-align: right;
        }

        .dedicated-node-buy {
            flex: 0 0 auto;
            min-width: 88px;
        }

        @media (max-width: 575.98px) {
            .dedicated-node-status {
                flex-basis: 100%;
                text-align: left;
            }
        }
    </style>
    {include file='include/global/head.tpl'}
    <div class="d-flex flex-column flex-root">
        <div class="d-flex flex-row flex-column-fluid page">
            <div class="d-flex flex-column flex-row-fluid wrapper" id="kt_wrapper">
                {include file='include/global/menu.tpl'}
                <div class="content d-flex flex-column flex-column-fluid" id="kt_content">
                    <div class="subheader min-h-lg-175px pt-5 pb-7 subheader-transparent">
                        <div class="container"><h2 class="text-white font-weight-bold my-2">专用节点</h2></div>
                    </div>
                    <div class="d-flex flex-column-fluid"><div class="container"><div class="row">
                        {foreach $dedicated_nodes as $item}
                            {$node = $item['node']} {$access = $item['access']}
                            <div class="col-md-6 col-xl-4 mb-6">
                                <div class="card card-custom h-100">
                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex align-items-center mb-3">
                                            <img alt="节点地区" class="mr-3 rounded-circle" width="42" height="42"
                                                 src="{$metron['assets_url']}/media/flags/1x1_zh_cn/{$item['flag']}.svg">
                                            <h3 class="font-weight-bolder mb-0">{$node->name}</h3>
                                        </div>
                                        <div class="text-muted mb-3">IP：{$node->getMaskedIp()}</div>
                                        <div class="mb-4">{$node->info}</div>
                                        {if $item['unlock_items']}
                                            <div style="border-top: 2px dashed #ECF0F3;
                                        border-bottom-right-radius: 0.42rem;
                                        border-bottom-left-radius: 0.42rem;
                                        margin-top: 20px;
                                        margin-bottom: 10px;"></div>
                                            <div style="padding: 15px; background-color: #f8f9fa; border-radius: 0.42rem; margin-bottom: 20px;">
                                                <div style="display: flex; flex-wrap: wrap; gap: 12px; font-size: 0.9rem;">
                                                    {foreach $item['unlock_items'] as $unlockItem}
                                                        <span style="white-space: nowrap;"><strong>{$unlockItem['label']}:</strong> <span style="color: {if strpos($unlockItem['value'], 'Yes') !== false}#1BC5BD{elseif strpos($unlockItem['value'], 'No') !== false}#F64E60{else}#FFA800{/if};">{$unlockItem['value']}</span></span>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        {/if}
                                        <div class="mt-auto pt-4 dedicated-node-footer">
                                            <div class="d-flex justify-content-between align-items-end flex-wrap dedicated-node-footer-row">
                                                <div class="dedicated-node-price"><strong class="font-size-h3">{$node->dedicated_price}</strong> 元 / {$node->dedicated_days} 天</div>
                                            {if $access}
                                                <span class="label label-success dedicated-node-status">有效至 {$item['expire_text']}，专用流量 {$item['traffic_text']}</span>
                                            {elseif $item['occupied']}
                                                <span class="label label-secondary dedicated-node-status">已售出</span>
                                            {else}
                                                <button type="button" class="btn btn-primary dedicated-node-buy" onclick="dedicatedBuy({$node->id}, '{$node->name|escape:'javascript'}', '{$node->dedicated_price}')">购买</button>
                                            {/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {foreachelse}
                            <div class="col-12"><div class="alert alert-light">暂无可购买的专用节点</div></div>
                        {/foreach}
                    </div></div></div>
                </div>
                {include file='include/global/footer.tpl'}
            </div>
        </div>
    </div>
    {include file='include/global/scripts.tpl'}
    <div class="modal fade" id="dedicated-payment-modal" data-backdrop="static" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">选择支付方式</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <p id="dedicated-payment-summary" class="font-weight-bold"></p>
                    <p class="text-muted">完成支付后，系统会自动开通专用节点。</p>
                    <div class="row">
                        {if $config['payment_system'] == 'metronpay'}
                            {if $metron['pay_alipay'] != 'none' && $metron['pay_alipay'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-primary btn-block dedicated-pay-option" data-type="pay_alipay">支付宝</button></div>
                            {/if}
                            {if $metron['pay_alipay_2'] != 'none' && $metron['pay_alipay_2'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-primary btn-block dedicated-pay-option" data-type="pay_alipay_2">支付宝</button></div>
                            {/if}
                            {if $metron['pay_alipay_3'] != 'none' && $metron['pay_alipay_3'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-primary btn-block dedicated-pay-option" data-type="pay_alipay_3">支付宝</button></div>
                            {/if}
                            {if $metron['pay_wxpay'] != 'none' && $metron['pay_wxpay'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-success btn-block dedicated-pay-option" data-type="pay_wxpay">微信支付</button></div>
                            {/if}
                            {if $metron['pay_wxpay_2'] != 'none' && $metron['pay_wxpay_2'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-success btn-block dedicated-pay-option" data-type="pay_wxpay_2">微信支付</button></div>
                            {/if}
                            {if $metron['pay_wxpay_3'] != 'none' && $metron['pay_wxpay_3'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-success btn-block dedicated-pay-option" data-type="pay_wxpay_3">微信支付</button></div>
                            {/if}
                            {if $metron['pay_qqpay'] != 'none' && $metron['pay_qqpay'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-info btn-block dedicated-pay-option" data-type="pay_qqpay">QQ钱包</button></div>
                            {/if}
                            {if $metron['pay_crypto'] != 'none' && $metron['pay_crypto'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-warning btn-block dedicated-pay-option" data-type="pay_crypto">数字货币</button></div>
                            {/if}
                        {/if}
                    </div>
                    <div id="dedicated-payment-result" class="alert alert-light mt-3" style="display: none;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    {literal}
    <script>
        (function () {
            var dedicatedPaymentNodeId = 0;
            var dedicatedPaymentPrice = 0;
            var modal = document.getElementById('dedicated-payment-modal');
            var summary = document.getElementById('dedicated-payment-summary');
            var result = document.getElementById('dedicated-payment-result');
            var buttons = document.querySelectorAll('.dedicated-pay-option');

            function setResult(message, isError, html) {
                result.className = 'alert mt-3 ' + (isError ? 'alert-danger' : 'alert-light');
                if (html) {
                    result.innerHTML = message;
                } else {
                    result.textContent = message;
                }
                result.style.display = 'block';
            }

            function showModal() {
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery('#dedicated-payment-modal').modal('show');
                    return;
                }
                modal.style.display = 'block';
                modal.classList.add('show');
                modal.setAttribute('aria-hidden', 'false');
            }

            function hideModal() {
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery('#dedicated-payment-modal').modal('hide');
                    return;
                }
                modal.style.display = 'none';
                modal.classList.remove('show');
                modal.setAttribute('aria-hidden', 'true');
            }

            window.dedicatedBuy = function (nodeId, nodeName, price) {
                dedicatedPaymentNodeId = parseInt(nodeId, 10);
                dedicatedPaymentPrice = parseFloat(price);
                summary.textContent = nodeName + '，应付 ' + dedicatedPaymentPrice.toFixed(2) + ' 元';
                result.style.display = 'none';
                result.textContent = '';
                Array.prototype.forEach.call(buttons, function (button) {
                    button.disabled = false;
                    button.textContent = button.getAttribute('data-label');
                });
                showModal();
            };

            Array.prototype.forEach.call(document.querySelectorAll('[data-dismiss="modal"]'), function (button) {
                button.addEventListener('click', hideModal);
            });

            Array.prototype.forEach.call(buttons, function (button) {
                button.setAttribute('data-label', button.textContent);
                button.addEventListener('click', function () {
                    var paymentType = button.getAttribute('data-type');
                    var body = new URLSearchParams();
                    body.set('price', dedicatedPaymentPrice);
                    body.set('type', paymentType);
                    body.set('shopid', '0');
                    body.set('dedicated_node_id', dedicatedPaymentNodeId);
                    button.disabled = true;
                    button.textContent = '正在创建订单...';
                    Array.prototype.forEach.call(buttons, function (item) {
                        item.disabled = true;
                    });

                    fetch('/user/payment/purchase', {
                        method: 'POST',
                        credentials: 'same-origin',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                        body: body.toString()
                    }).then(function (response) {
                        return response.text().then(function (text) {
                            var data = null;
                            try { data = JSON.parse(text); } catch (error) { data = null; }
                            if (!response.ok) {
                                throw new Error('创建支付订单失败：' + response.status);
                            }
                            return data;
                        });
                    }).then(function (data) {
                        if (!data || data.ret !== 1) {
                            throw new Error((data && data.msg) || '创建支付订单失败');
                        }
                        setResult('订单已创建，请完成支付：<a class="btn btn-primary ml-2" target="_blank" rel="noopener" href="' + data.url + '">前往支付</a>', false, true);
                        button.textContent = '订单已创建';
                    }).catch(function (error) {
                        setResult(error.message || '创建支付订单失败', true, false);
                        Array.prototype.forEach.call(buttons, function (item) {
                            item.disabled = false;
                        });
                        button.textContent = '重新支付';
                    });
                });
            });
        }());
    </script>
    {/literal}
</body>
</html>
