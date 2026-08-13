<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>专用节点 &mdash; {$config["appName"]}</title>
    <style>
        .dedicated-payment-modal .modal-dialog {
            max-width: 520px;
        }

        .dedicated-payment-modal .modal-content {
            overflow: hidden;
            border: 0;
            box-shadow: 0 20px 48px rgba(31, 45, 61, 0.18);
        }

        .dedicated-payment-modal .modal-header {
            padding: 24px 28px 20px;
            border-bottom: 1px dashed #e5eaf0;
        }

        .dedicated-payment-modal .modal-body {
            padding: 24px 28px 28px;
        }

        .dedicated-payment-summary {
            margin-bottom: 8px;
            color: #3f4960;
            font-size: 1.1rem;
        }

        .dedicated-payment-hint {
            margin-bottom: 20px;
        }

        .dedicated-pay-grid {
            margin: 0 -6px;
        }

        .dedicated-pay-grid > div {
            padding: 0 6px 12px;
        }

        .dedicated-pay-option {
            min-height: 52px;
            border-radius: 8px;
            font-weight: 600;
            transition: transform 150ms ease, box-shadow 150ms ease;
        }

        .dedicated-pay-option:not(:disabled):hover,
        .dedicated-pay-option:not(:disabled):focus {
            transform: translateY(-1px);
            box-shadow: 0 5px 14px rgba(31, 45, 61, 0.12);
        }

        .dedicated-payment-result {
            margin-top: 8px;
            margin-bottom: 0;
            border-radius: 8px;
        }

        .dedicated-payment-qr {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            padding: 18px;
            background: #f7f9fb;
            border-radius: 8px;
            text-align: center;
        }

        .dedicated-payment-qr canvas,
        .dedicated-payment-qr img {
            display: block;
            width: 220px;
            height: 220px;
            max-width: 100%;
            padding: 8px;
            background: #fff;
        }

        .dedicated-payment-modal .modal-footer {
            padding: 16px 28px 20px;
            border-top: 1px dashed #e5eaf0;
        }

        @media (max-width: 575.98px) {
            .dedicated-payment-modal .modal-header,
            .dedicated-payment-modal .modal-body,
            .dedicated-payment-modal .modal-footer {
                padding-left: 20px;
                padding-right: 20px;
            }
        }

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
                                                <div class="dedicated-node-price">
                                                    <div><strong class="font-size-h3">{$node->dedicated_price}</strong> 元 / {$node->dedicated_days} 天</div>
                                                    <div class="text-muted mt-2">专用流量 {$item['dedicated_traffic_text']}</div>
                                                </div>
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
    <div class="modal fade dedicated-payment-modal" id="dedicated-payment-modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dedicated-payment-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dedicated-payment-title">选择支付方式</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <p id="dedicated-payment-summary" class="font-weight-bold dedicated-payment-summary"></p>
                    <p class="text-muted dedicated-payment-hint">选择支付方式后会直接打开支付页面，完成支付后自动开通。</p>
                    <div class="row dedicated-pay-grid">
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
                    <div id="dedicated-payment-result" class="alert alert-light dedicated-payment-result" style="display: none;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/js/qrcode.min.js"></script>
    {literal}
    <script>
        (function () {
            var dedicatedPaymentNodeId = 0;
            var dedicatedPaymentPrice = 0;
            var modal = document.getElementById('dedicated-payment-modal');
            var title = document.getElementById('dedicated-payment-title');
            var summary = document.getElementById('dedicated-payment-summary');
            var result = document.getElementById('dedicated-payment-result');
            var buttons = document.querySelectorAll('.dedicated-pay-option');
            var pollTimer = null;
            var paymentWindow = null;

            function setResult(message, isError, html) {
                result.className = 'alert mt-3 ' + (isError ? 'alert-danger' : 'alert-light');
                if (html) {
                    result.innerHTML = message;
                } else {
                    result.textContent = message;
                }
                result.style.display = 'block';
            }

            function clearResult() {
                result.className = 'alert dedicated-payment-result';
                result.innerHTML = '';
                result.style.display = 'none';
            }

            function stopPolling() {
                if (pollTimer !== null) {
                    window.clearTimeout(pollTimer);
                    pollTimer = null;
                }
            }

            function startPolling(tradeno) {
                var attempts = 0;
                stopPolling();

                function poll() {
                    attempts += 1;
                    if (attempts > 120) {
                        return;
                    }
                    var body = new URLSearchParams();
                    body.set('tradeno', tradeno);
                    fetch('/doiam/status', {
                        method: 'POST',
                        credentials: 'same-origin',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                        body: body.toString()
                    }).then(function (response) {
                        return response.json();
                    }).then(function (data) {
                        if (data && parseInt(data.result, 10) === 1) {
                            title.textContent = '支付完成';
                            setResult('支付已完成，正在刷新专用节点状态...', false, false);
                            window.setTimeout(function () {
                                window.location.reload();
                            }, 1000);
                            return;
                        }
                        pollTimer = window.setTimeout(poll, 1500);
                    }).catch(function () {
                        pollTimer = window.setTimeout(poll, 2500);
                    });
                }

                poll();
            }

            function renderQrCode(url, tradeno) {
                result.className = 'alert dedicated-payment-result';
                result.innerHTML = '<div class="dedicated-payment-qr"><div class="font-weight-bold">请使用支付宝扫描二维码完成支付</div><div id="dedicated-payment-qr-code"></div><a class="text-muted" target="_blank" rel="noopener">手机打开支付链接</a><div class="text-muted">支付完成后页面会自动刷新</div></div>';
                result.style.display = 'block';
                var qrContainer = document.getElementById('dedicated-payment-qr-code');
                var link = result.querySelector('a');
                link.href = url;
                if (window.QRCode) {
                    new window.QRCode(qrContainer, {width: 220, height: 220, text: url});
                } else {
                    qrContainer.textContent = '二维码加载失败，请点击下方链接支付';
                }
                startPolling(tradeno);
            }

            function openPaymentUrl(url, tradeno) {
                if (paymentWindow && !paymentWindow.closed) {
                    paymentWindow.location.href = url;
                } else {
                    paymentWindow = window.open(url, '_blank', 'noopener');
                }
                result.className = 'alert dedicated-payment-result';
                result.innerHTML = '<div class="d-flex align-items-center justify-content-between flex-wrap"><span>支付页面已打开，完成支付后会自动刷新。</span><a class="btn btn-primary mt-2 mt-sm-0" target="_blank" rel="noopener">重新打开</a></div>';
                result.style.display = 'block';
                result.querySelector('a').href = url;
                startPolling(tradeno);
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
                stopPolling();
                paymentWindow = null;
                dedicatedPaymentNodeId = parseInt(nodeId, 10);
                dedicatedPaymentPrice = parseFloat(price);
                title.textContent = '选择支付方式';
                summary.textContent = nodeName + '，应付 ' + dedicatedPaymentPrice.toFixed(2) + ' 元';
                clearResult();
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
                    paymentWindow = window.open('about:blank', '_blank');
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
                        title.textContent = '完成支付';
                        if (data.type === 'qrcode') {
                            if (paymentWindow && !paymentWindow.closed) {
                                paymentWindow.close();
                            }
                            paymentWindow = null;
                            renderQrCode(data.url, data.tradeno);
                        } else {
                            openPaymentUrl(data.url, data.tradeno);
                        }
                        button.textContent = '支付处理中';
                    }).catch(function (error) {
                        if (paymentWindow && !paymentWindow.closed && paymentWindow.location.href === 'about:blank') {
                            paymentWindow.close();
                        }
                        paymentWindow = null;
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
