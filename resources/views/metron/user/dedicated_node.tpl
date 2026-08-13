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

        .dedicated-node-card {
            overflow: hidden;
            border: 1px solid rgba(226, 232, 240, 0.9);
            transition: transform 180ms ease, box-shadow 180ms ease;
        }

        .dedicated-node-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 28px rgba(31, 45, 61, 0.12);
        }

        .dedicated-node-body {
            padding: 0 !important;
        }

        .dedicated-node-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 22px 24px 20px;
            background: rgba(247, 249, 252, 0.72);
            border-bottom: 1px solid #edf0f4;
        }

        .dedicated-node-heading {
            display: flex;
            align-items: center;
            min-width: 0;
            gap: 14px;
        }

        .dedicated-node-flag {
            flex: 0 0 auto;
            width: 48px;
            height: 48px;
            box-shadow: 0 5px 12px rgba(31, 45, 61, 0.12);
        }

        .dedicated-node-title {
            min-width: 0;
            margin: 0;
            color: #3f4960;
            font-size: 1.35rem;
            line-height: 1.25;
            overflow-wrap: anywhere;
        }

        .dedicated-node-type {
            margin-bottom: 4px;
            color: #a6afbf;
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 0.08em;
        }

        .dedicated-node-state {
            flex: 0 0 auto;
            white-space: nowrap;
        }

        .dedicated-node-main {
            display: flex;
            flex: 1 1 auto;
            flex-direction: column;
            padding: 22px 24px 0;
        }

        .dedicated-node-description {
            min-height: 42px;
            margin-bottom: 18px;
            color: #677286;
            line-height: 1.65;
        }

        .dedicated-node-empty-description {
            color: #b1bac8;
        }

        .dedicated-node-facts {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 10px;
            margin-bottom: 22px;
        }

        .dedicated-node-fact {
            min-width: 0;
            padding: 12px 14px;
            background: #f8fafc;
            border-radius: 8px;
        }

        .dedicated-node-fact-label {
            display: block;
            margin-bottom: 5px;
            color: #a0aaba;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .dedicated-node-fact-value {
            display: block;
            overflow: hidden;
            color: #4e596d;
            font-size: 0.95rem;
            font-weight: 600;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .dedicated-node-unlock {
            padding-top: 18px;
            border-top: 1px dashed #e4e9ef;
        }

        .dedicated-node-unlock-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 12px;
        }

        .dedicated-node-unlock-title {
            margin: 0;
            color: #677286;
            font-size: 0.86rem;
            font-weight: 700;
        }

        .dedicated-node-unlock-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 10px 18px;
            padding-bottom: 22px;
        }

        .dedicated-node-unlock-item {
            display: flex;
            align-items: center;
            min-width: 0;
            gap: 7px;
            color: #556074;
            font-size: 0.88rem;
        }

        .dedicated-node-unlock-dot {
            flex: 0 0 auto;
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #aab4c2;
        }

        .dedicated-node-unlock-item.is-yes .dedicated-node-unlock-dot {
            background: #1bc5bd;
        }

        .dedicated-node-unlock-item.is-no .dedicated-node-unlock-dot {
            background: #f64e60;
        }

        .dedicated-node-unlock-label {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .dedicated-node-unlock-value {
            flex: 0 0 auto;
            font-weight: 600;
        }

        .dedicated-node-unlock-item.is-yes .dedicated-node-unlock-value {
            color: #1baea7;
        }

        .dedicated-node-unlock-item.is-no .dedicated-node-unlock-value {
            color: #e7475b;
        }

        .dedicated-node-unlock-item.is-neutral .dedicated-node-unlock-value {
            color: #a17b00;
        }

        .dedicated-node-footer {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 18px;
            margin-top: auto;
            padding: 18px 24px 22px;
            border-top: 1px solid #edf0f4;
        }

        .dedicated-node-price {
            min-width: 0;
        }

        .dedicated-node-price-line {
            display: flex;
            align-items: baseline;
            gap: 8px;
            color: #596377;
        }

        .dedicated-node-price-value {
            color: #3f4960;
            font-size: 2rem;
            line-height: 1;
        }

        .dedicated-node-price-unit {
            font-size: 0.95rem;
            font-weight: 600;
        }

        .dedicated-node-term {
            color: #8993a4;
            font-size: 0.9rem;
        }

        .dedicated-node-access-meta {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 4px;
            color: #7e899a;
            font-size: 0.8rem;
            text-align: right;
        }

        .dedicated-node-buy {
            min-width: 108px;
            padding: 11px 22px;
            border-radius: 8px;
            font-weight: 700;
        }

        @media (max-width: 767.98px) {
            .dedicated-node-header,
            .dedicated-node-main,
            .dedicated-node-footer {
                padding-left: 18px;
                padding-right: 18px;
            }

            .dedicated-node-header {
                align-items: flex-start;
            }

            .dedicated-node-facts {
                grid-template-columns: 1fr;
            }

            .dedicated-node-footer {
                align-items: flex-start;
                flex-wrap: wrap;
            }

            .dedicated-node-access-meta {
                align-items: flex-start;
                text-align: left;
            }
        }

        @media (max-width: 479.98px) {
            .dedicated-node-header {
                flex-wrap: wrap;
            }

            .dedicated-node-unlock-grid {
                grid-template-columns: 1fr;
            }

            .dedicated-node-view-button {
                margin-top: 8px;
                padding: 10px 16px !important;
            }
        }

    </style>
    {include file='include/global/head.tpl'}
    <div class="d-flex flex-column flex-root">
        <div class="d-flex flex-row flex-column-fluid page">
            <div class="d-flex flex-column flex-row-fluid wrapper" id="kt_wrapper">
                {include file='include/global/menu.tpl'}
                <div class="content d-flex flex-column flex-column-fluid" id="kt_content">
                    <div class="subheader min-h-lg-175px pt-5 pb-7 subheader-transparent" id="kt_subheader">
                        <div class="container d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
                            <div class="d-flex align-items-center flex-wrap mr-2">
                                <div class="d-flex flex-column">
                                    <h2 class="text-white font-weight-bold my-2 mr-5">{if $dedicated_view == 'mine'}我的专用节点{else}专用节点{/if}</h2>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                {if $dedicated_view == 'mine'}
                                    <a href="/user/dedicated-node"
                                       class="btn {$style[$theme_style]['global']['btn_subheader']} font-weight-bold py-3 px-6 dedicated-node-view-button">全部专用节点</a>
                                {else}
                                    <a href="/user/dedicated-node?view=mine"
                                       class="btn {$style[$theme_style]['global']['btn_subheader']} font-weight-bold py-3 px-6 dedicated-node-view-button">我的专用节点{if $dedicated_owned_count > 0} · {$dedicated_owned_count}{/if}</a>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="d-flex flex-column-fluid"><div class="container"><div class="row">
                        {foreach $dedicated_nodes as $item}
                            {$node = $item['node']} {$access = $item['access']}
                            <div class="col-md-6 col-xl-4 mb-6">
                                <div class="card card-custom h-100 dedicated-node-card">
                                    <div class="card-body d-flex flex-column dedicated-node-body">
                                        <div class="dedicated-node-header">
                                            <div class="dedicated-node-heading">
                                                <img alt="节点地区" class="rounded-circle dedicated-node-flag"
                                                     width="48" height="48"
                                                     src="{$metron['assets_url']}/media/flags/1x1_zh_cn/{$item['flag']}.svg">
                                                <div class="min-w-0">
                                                    <div class="dedicated-node-type">专用 IP 节点</div>
                                                    <h3 class="font-weight-bolder dedicated-node-title">{$node->name}</h3>
                                                </div>
                                            </div>
                                            {if $access}
                                                <span class="label label-success dedicated-node-state">已拥有</span>
                                            {elseif $item['occupied']}
                                                <span class="label label-secondary dedicated-node-state">已售出</span>
                                            {else}
                                                <span class="label label-light-primary dedicated-node-state">可购买</span>
                                            {/if}
                                        </div>
                                        <div class="dedicated-node-main">
                                            <div class="dedicated-node-description">
                                                {if $node->info}
                                                    {$node->info}
                                                {else}
                                                    <span class="dedicated-node-empty-description">暂无节点描述</span>
                                                {/if}
                                            </div>
                                            <div class="dedicated-node-facts">
                                                <div class="dedicated-node-fact">
                                                    <span class="dedicated-node-fact-label">IP 地址</span>
                                                    <span class="dedicated-node-fact-value" title="{$node->getMaskedIp()}">{$node->getMaskedIp()}</span>
                                                </div>
                                                <div class="dedicated-node-fact">
                                                    <span class="dedicated-node-fact-label">专用流量</span>
                                                    <span class="dedicated-node-fact-value">{$item['dedicated_traffic_text']}</span>
                                                </div>
                                                <div class="dedicated-node-fact">
                                                    <span class="dedicated-node-fact-label">授权周期</span>
                                                    <span class="dedicated-node-fact-value">{$node->dedicated_days} 天</span>
                                                </div>
                                            </div>
                                        {if $item['unlock_items']}
                                            <div class="dedicated-node-unlock">
                                                <div class="dedicated-node-unlock-heading">
                                                    <h4 class="dedicated-node-unlock-title">流媒体与 AI 解锁</h4>
                                                    <span class="text-muted font-size-sm">{$item['unlock_items']|count} 项</span>
                                                </div>
                                                <div class="dedicated-node-unlock-grid">
                                                    {foreach $item['unlock_items'] as $unlockItem}
                                                        <div class="dedicated-node-unlock-item {if strpos($unlockItem['value'], 'Yes') !== false}is-yes{elseif strpos($unlockItem['value'], 'No') !== false}is-no{else}is-neutral{/if}">
                                                            <span class="dedicated-node-unlock-dot"></span>
                                                            <span class="dedicated-node-unlock-label">{$unlockItem['label']}</span>
                                                            <span class="dedicated-node-unlock-value">{$unlockItem['value']}</span>
                                                        </div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        {/if}
                                        </div>
                                        <div class="dedicated-node-footer">
                                            <div class="dedicated-node-price">
                                                <div class="dedicated-node-price-line">
                                                    <strong class="dedicated-node-price-value">{$node->dedicated_price}</strong>
                                                    <span class="dedicated-node-price-unit">元</span>
                                                    <span class="dedicated-node-term">/ {$node->dedicated_days} 天</span>
                                                </div>
                                            </div>
                                            {if $access}
                                                <div class="dedicated-node-access-meta">
                                                    <span>有效至 {$item['expire_text']}</span>
                                                    <span>剩余专用流量 {$item['traffic_text']}</span>
                                                </div>
                                            {elseif $item['occupied']}
                                                <span class="label label-secondary dedicated-node-state">已售出</span>
                                            {else}
                                                <button type="button" class="btn btn-primary dedicated-node-buy" onclick="dedicatedBuy({$node->id}, '{$node->name|escape:'javascript'}', '{$node->dedicated_price}')">购买</button>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {foreachelse}
                            <div class="col-12">
                                <div class="alert alert-light d-flex align-items-center justify-content-between flex-wrap py-5 px-6">
                                    <span>{if $dedicated_view == 'mine'}您当前没有有效的专用节点{else}暂无可购买的专用节点{/if}</span>
                                    {if $dedicated_view == 'mine'}
                                        <a href="/user/dedicated-node" class="btn btn-sm btn-primary mt-3 mt-sm-0">查看全部节点</a>
                                    {/if}
                                </div>
                            </div>
                        {/foreach}
                    </div></div></div>
                </div>
                {include file='include/global/footer.tpl'}
            </div>
        </div>
    </div>
    {include file='include/global/scripts.tpl'}
    <div class="modal fade dedicated-payment-modal" id="dedicated-payment-modal" data-user-balance="{$user->money|escape:'htmlall'}" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dedicated-payment-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dedicated-payment-title">选择支付方式</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <p id="dedicated-payment-summary" class="font-weight-bold dedicated-payment-summary"></p>
                    <p class="text-muted dedicated-payment-hint">二维码支付会直接显示在这里，网页支付会自动打开新标签页。</p>
                    <div class="row dedicated-pay-grid">
                        {if $config['payment_system'] == 'metronpay'}
                            {if $metron['pay_alipay'] != 'none' && $metron['pay_alipay'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-primary btn-block dedicated-pay-option" data-type="pay_alipay" data-payment-mode="{if $metron['pay_alipay'] == 'f2fpay' || $metron['pay_alipay'] == 'vmq'}qrcode{else}url{/if}">支付宝</button></div>
                            {/if}
                            {if $metron['pay_alipay_2'] != 'none' && $metron['pay_alipay_2'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-primary btn-block dedicated-pay-option" data-type="pay_alipay_2" data-payment-mode="{if $metron['pay_alipay_2'] == 'f2fpay' || $metron['pay_alipay_2'] == 'vmq'}qrcode{else}url{/if}">支付宝</button></div>
                            {/if}
                            {if $metron['pay_alipay_3'] != 'none' && $metron['pay_alipay_3'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-primary btn-block dedicated-pay-option" data-type="pay_alipay_3" data-payment-mode="{if $metron['pay_alipay_3'] == 'f2fpay' || $metron['pay_alipay_3'] == 'vmq'}qrcode{else}url{/if}">支付宝</button></div>
                            {/if}
                            {if $metron['pay_wxpay'] != 'none' && $metron['pay_wxpay'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-success btn-block dedicated-pay-option" data-type="pay_wxpay" data-payment-mode="{if $metron['pay_wxpay'] == 'payjs' || $metron['pay_wxpay'] == 'vmq'}qrcode{else}url{/if}">微信支付</button></div>
                            {/if}
                            {if $metron['pay_wxpay_2'] != 'none' && $metron['pay_wxpay_2'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-success btn-block dedicated-pay-option" data-type="pay_wxpay_2" data-payment-mode="{if $metron['pay_wxpay_2'] == 'payjs' || $metron['pay_wxpay_2'] == 'vmq'}qrcode{else}url{/if}">微信支付</button></div>
                            {/if}
                            {if $metron['pay_wxpay_3'] != 'none' && $metron['pay_wxpay_3'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-success btn-block dedicated-pay-option" data-type="pay_wxpay_3" data-payment-mode="{if $metron['pay_wxpay_3'] == 'payjs' || $metron['pay_wxpay_3'] == 'vmq'}qrcode{else}url{/if}">微信支付</button></div>
                            {/if}
                            {if $metron['pay_qqpay'] != 'none' && $metron['pay_qqpay'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-info btn-block dedicated-pay-option" data-type="pay_qqpay">QQ钱包</button></div>
                            {/if}
                            {if $metron['pay_crypto'] != 'none' && $metron['pay_crypto'] != ''}
                                <div class="col-6 mb-3"><button type="button" class="btn btn-light-warning btn-block dedicated-pay-option" data-type="pay_crypto">数字货币</button></div>
                            {/if}
                        {/if}
                        <div class="col-6 mb-3"><button type="button" class="btn btn-light-secondary btn-block dedicated-pay-option" data-type="balance" data-payment-mode="balance">余额支付（余额 {$user->money} 元）</button></div>
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
            var dedicatedPaymentBalance = parseFloat(modal.getAttribute('data-user-balance')) || 0;
            var title = document.getElementById('dedicated-payment-title');
            var summary = document.getElementById('dedicated-payment-summary');
            var result = document.getElementById('dedicated-payment-result');
            var buttons = document.querySelectorAll('.dedicated-pay-option');
            var pollTimer = null;
            var paymentWindow = null;
            var paymentWindowPending = false;

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
                paymentWindowPending = false;
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
                paymentWindowPending = false;
                dedicatedPaymentNodeId = parseInt(nodeId, 10);
                dedicatedPaymentPrice = parseFloat(price);
                title.textContent = '选择支付方式';
                var balanceUsed = Math.min(Math.max(dedicatedPaymentBalance, 0), dedicatedPaymentPrice);
                var onlineAmount = Math.max(0, dedicatedPaymentPrice - balanceUsed);
                summary.textContent = nodeName + '，总价 ' + dedicatedPaymentPrice.toFixed(2) + ' 元；余额抵扣 ' + balanceUsed.toFixed(2) + ' 元，在线支付 ' + onlineAmount.toFixed(2) + ' 元';
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
                    var isBalancePayment = paymentType === 'balance';
                    if (!isBalancePayment && button.getAttribute('data-payment-mode') === 'url') {
                        paymentWindow = window.open('about:blank', '_blank');
                        paymentWindowPending = true;
                    } else if (isBalancePayment) {
                        paymentWindow = null;
                        paymentWindowPending = false;
                    }
                    if (isBalancePayment) {
                        body.set('node_id', dedicatedPaymentNodeId);
                    } else {
                        var balanceUsed = Math.min(Math.max(dedicatedPaymentBalance, 0), dedicatedPaymentPrice);
                        body.set('price', Math.max(0, dedicatedPaymentPrice - balanceUsed).toFixed(2));
                        body.set('type', paymentType);
                        body.set('shopid', '0');
                        body.set('dedicated_node_id', dedicatedPaymentNodeId);
                    }
                    button.disabled = true;
                    button.textContent = '正在创建订单...';
                    Array.prototype.forEach.call(buttons, function (item) {
                        item.disabled = true;
                    });

                    fetch(isBalancePayment ? '/user/dedicated-node/buy' : '/user/payment/purchase', {
                        method: 'POST',
                        credentials: 'same-origin',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
                        body: body.toString()
                    }).then(function (response) {
                        return response.text().then(function (text) {
                            var data = null;
                            try { data = JSON.parse(text); } catch (error) { data = null; }
                            if (!response.ok) {
                                throw new Error((isBalancePayment ? '余额支付失败：' : '创建支付订单失败：') + response.status);
                            }
                            return data;
                        });
                    }).then(function (data) {
                        if (!data || data.ret !== 1) {
                            throw new Error((data && data.msg) || (isBalancePayment ? '余额支付失败' : '创建支付订单失败'));
                        }
                        if (isBalancePayment) {
                            title.textContent = '购买成功';
                            setResult(data.msg || '余额支付成功，专用节点已开通', false, false);
                            button.textContent = '已开通';
                            window.setTimeout(function () {
                                window.location.reload();
                            }, 1000);
                            return;
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
                        if (paymentWindowPending && paymentWindow && !paymentWindow.closed) {
                            paymentWindow.close();
                        }
                        paymentWindow = null;
                        paymentWindowPending = false;
                        setResult(error.message || (isBalancePayment ? '余额支付失败' : '创建支付订单失败'), true, false);
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
