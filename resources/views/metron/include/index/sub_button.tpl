                                                        {if in_array('ssr',$metron['index_sub'])}
                                                        <!-- SSR订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-ssr dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="metron-ssr1 text-white"></i>&nbsp;&nbsp;SSR 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["ssr"]}">复制 SSR 订阅</button>
                                                                <div class="dropdown-divider">
                                                                </div>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('ssr')">一键导入 SSR</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('clash',$metron['index_sub'])}
                                                        <!-- Clash订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-clash dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="metron-clash text-white"></i>&nbsp;&nbsp;Clash 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["clash"]}">复制 Clash 订阅</button>
                                                                <div class="dropdown-divider">
                                                                </div>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('clash')">一键导入 Clash</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('sing-box',$metron['index_sub'])}
                                                        <!-- SingBox订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-clash dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <svg width="16" height="17" viewBox="0 0 1027 1109" xmlns="http://www.w3.org/2000/svg" style="display: inline-block; vertical-align: middle; margin-top: -2px;">
                                                                    <g transform="translate(-692, -855)">
                                                                        <path d="M692 1191 692 1575.69C692 1640.41 731.499 1651.19 731.499 1651.19L1148.03 1931.62C1212.66 1974.77 1194.71 1881.29 1194.71 1881.29L1194.71 1528.96 692 1191Z" fill="#B0BEC5"/>
                                                                        <path d="M1698 1191 1698 1575.69C1698 1640.41 1658.5 1651.19 1658.5 1651.19 1658.5 1651.19 1306.6 1888.48 1241.97 1931.62 1177.34 1974.77 1195.29 1881.29 1195.29 1881.29L1195.29 1528.96 1698 1191Z" fill="#90A4AE"/>
                                                                        <path d="M1241.71 868.473C1212.96 850.509 1169.85 850.509 1144.7 868.473L713.557 1163.07C684.814 1181.04 684.814 1213.37 713.557 1231.33L1144.7 1529.53C1173.44 1547.49 1216.56 1547.49 1241.71 1529.53L1676.44 1227.74C1705.19 1209.78 1705.19 1177.44 1676.44 1159.48L1241.71 868.473Z" fill="#CFD8DC"/>
                                                                        <path d="M1553.92 1435.92C1553.92 1471.89 1557.5 1486.27 1518.03 1511.45L1428.32 1568.99C1388.85 1594.17 1374.5 1572.59 1374.5 1540.22L1374.5 1446.71C1374.5 1439.52 1374.5 1435.92 1363.73 1428.73 1270.43 1363.99 911.591 1115.84 847 1069.09L1012.07 954C1058.72 982.772 1399.61 1209.35 1539.56 1306.45 1546.74 1310.05 1550.33 1317.24 1550.33 1320.84L1550.33 1435.92Z" fill="#ECEFF1"/>
                                                                        <path d="M1543.41 1310.21C1399.82 1213.17 1058.79 986.752 1015.72 958L951.103 997.534 847 1069.41C911.615 1116.14 1270.59 1360.53 1363.92 1425.22 1371.1 1428.81 1371.1 1432.41 1371.1 1436L1547 1313.8C1547 1313.8 1547 1310.21 1543.41 1310.21Z" fill="#FFFFFF"/>
                                                                    </g>
                                                                </svg>&nbsp;&nbsp;SingBox 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["singbox"]}">复制 SingBox 订阅</button>
                                                                <div class="dropdown-divider">
                                                                </div>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('singbox')">一键导入 SingBox</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('surge',$metron['index_sub'])}
                                                        <!-- Surge订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-surge dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="metron-surge text-white"></i>&nbsp;&nbsp;Surge 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["surge2"]}">复制 Surge 2 节点订阅</button>
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["surge3"]}">复制 Surge 3 节点订阅</button>
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["surge4"]}">复制 Surge 4 节点订阅</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('shadowrocket',$metron['index_sub'])}
                                                        <!-- Shadowrocket订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-shadowrocket dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="metron-shadowrocket text-white"></i>&nbsp;&nbsp;Shadowrocket 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item" href="##" onclick="qrcodeSublink('shadowrocket')">扫描二维码添加订阅</button>
                                                                <div class="dropdown-divider"></div>
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["shadowrocket"]}">复制 Shadowrocket 订阅</button>
                                                                <div class="dropdown-divider"></div>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('shadowrocket')">一键导入 Shadowrocket</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('stash',$metron['index_sub'])}
                                                            <!-- Stash -->
                                                            <div class="btn-group mb-3 mr-3">
                                                                <button type="button" class="btn btn-pill btn-surfboard dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                    <img src="https://stash.wiki/favicon-96x96.png" width="16" height="16" style="display: inline-block; vertical-align: middle; margin-top: -2px;">&nbsp;&nbsp;Stash 订阅&nbsp;&nbsp;</button>
                                                                <div class="dropdown-menu">
                                                                    <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["stash"]}">复制 Stash 订阅</button>
                                                                    <div class="dropdown-divider"></div>
                                                                    <button type="button" class="dropdown-item" href="##" onclick="importSublink('stash')">一键导入 Stash</button>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                        {if in_array('quantumult',$metron['index_sub'])}
                                                        <!-- Quantumult订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-quantumult dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="metron-quantumult text-white"></i>&nbsp;&nbsp;Quantumult 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["ssr"]}">复制 SSR 节点订阅</button>
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["quantumult_v2"]}">复制 V2ray 节点订阅</button>
                                                                <div class="dropdown-divider"></div>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('quantumult')">一键导入 SSR 节点订阅</button>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('quantumult_v2')">一键导入 V2Ray 节点订阅</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('quantumultx',$metron['index_sub'])}
                                                        <!-- QuantumultX订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-quantumultx dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="metron-quantumultx text-white"></i>&nbsp;&nbsp;Quantumult X 订阅&nbsp;&nbsp;</button>
                                                            <div class="dropdown-menu">
                                                                <button type="button" class="dropdown-item copy-text" data-clipboard-text="{$subInfo["quantumultx"]}">复制 Quantumult X 订阅</button>
                                                                <div class="dropdown-divider"></div>
                                                                <button type="button" class="dropdown-item" href="##" onclick="importSublink('quantumultx')">一键导入 Quantumult X</button>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        {if in_array('v2ray',$metron['index_sub'])}
                                                        <!-- V2Ray订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-v2ray copy-text" data-clipboard-text="{$subInfo["v2ray"]}"><i class="metron-v2rayng text-white"></i>&nbsp;&nbsp;复制 V2Ray 订阅&nbsp;&nbsp;</button>
                                                        </div>
                                                        {/if}
                                                        {if in_array('v2ray',$metron['index_sub'])}
                                                            <!-- V2Ray订阅 -->
                                                            <div class="btn-group mb-3 mr-3">
                                                                <button type="button" class="btn btn-pill btn-v2ray copy-text" data-clipboard-text="{$subInfo["v2ray_vless"]}"><i class="metron-v2rayng text-white"></i>&nbsp;&nbsp;复制 V2Ray-VLESS 订阅&nbsp;&nbsp;</button>
                                                            </div>
                                                        {/if}
                                                        {if in_array('surfboard',$metron['index_sub'])}
                                                        <!-- Surfboard订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-surfboard copy-text" data-clipboard-text="{$subInfo["surfboard"]}"><i class="metron-surfboard text-white"></i>&nbsp;&nbsp;复制 Surfboard 订阅&nbsp;&nbsp;</button>
                                                        </div>
                                                        {/if}
                                                        {if in_array('kitsunebi',$metron['index_sub'])}
                                                        <!-- Kitsunebi订阅 -->
                                                        <div class="btn-group mb-3 mr-3">
                                                            <button type="button" class="btn btn-pill btn-kitsunebi copy-text" data-clipboard-text="{$subInfo["kitsunebi"]}"><i class="metron-kitsunebi text-white"></i>&nbsp;&nbsp;复制 Kitsunebi 订阅&nbsp;&nbsp;</button>
                                                        </div>
                                                        {/if}
