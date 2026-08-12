<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>专用节点 &mdash; {$config["appName"]}</title>
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
                            {$shop = $item['shop']} {$node = $item['node']} {$access = $item['access']}
                            <div class="col-md-6 col-xl-4 mb-6">
                                <div class="card card-custom h-100">
                                    <div class="card-body d-flex flex-column">
                                        <h3 class="font-weight-bolder">{$node->name}</h3>
                                        <div class="text-muted mb-3">IP：{$node->getMaskedIp()}</div>
                                        <div class="mb-4">{$node->info}</div>
                                        {if $item['unlock_text'] != ''}
                                            <div class="text-muted mb-4">解锁：{$item['unlock_text']}</div>
                                        {/if}
                                        <div class="mt-auto d-flex justify-content-between align-items-center">
                                            <div><strong class="font-size-h3">{$shop->price}</strong> 元 / {$shop->accessDays()} 天</div>
                                            {if $access}
                                                <span class="label label-success">有效至 {$item['expire_text']}</span>
                                            {else}
                                                <button type="button" class="btn btn-primary" onclick="dedicatedBuy({$shop->id})">购买</button>
                                            {/if}
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
    {literal}
    <script>
        function dedicatedBuy(shopId) {
            $.post('/user/buy', {shop: shopId, coupon: '', disableothers: 0, autorenew: 0}, function (data) {
                if (data.ret === 1) {
                    alert(data.msg);
                    window.location.reload();
                    return;
                }
                alert(data.msg || '购买失败');
            }, 'json');
        }
    </script>
    {/literal}
</body>
</html>
