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

        .dedicated-pay-balance.btn {
            color: #3f4960;
            background: #eef2f6;
            border: 1px solid #dce3eb;
        }

        .dedicated-pay-balance.btn:hover:not(:disabled),
        .dedicated-pay-balance.btn:focus:not(:disabled) {
            color: #263043;
            background: #e3e9f0;
            border-color: #cfd8e3;
        }

        .dedicated-pay-balance.btn:disabled {
            color: #626c7d;
            background: #eef1f4;
            border-color: #dfe5eb;
            box-shadow: none;
            cursor: not-allowed;
            opacity: 1;
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

        .dedicated-node-title-line {
            display: flex;
            align-items: center;
            min-width: 0;
            gap: 8px;
        }

        .dedicated-node-online-dot {
            flex: 0 0 auto;
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
            min-width: 58px;
            height: 28px;
            padding: 0 10px !important;
            border-radius: 6px !important;
            font-size: 0.78rem;
            text-align: center;
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 0;
            padding: 12px 14px;
            overflow: hidden;
            background: #f8fafc;
            border-radius: 8px;
            box-sizing: border-box;
        }

        .dedicated-node-fact-heading {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            gap: 7px;
            margin-bottom: 5px;
        }

        .dedicated-node-fact-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 26px;
            height: 26px;
            flex: 0 0 26px;
            border-radius: 7px;
            background: #e9f0ff;
            color: #5d7fe8;
            font-size: 14px;
        }

        .dedicated-node-fact-heading > .dedicated-node-fact-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            line-height: 1;
            text-align: center;
        }

        .dedicated-node-fact-label {
            display: inline-block;
            color: #a0aaba;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .dedicated-node-fact-value {
            display: block;
            width: 100%;
            overflow: hidden;
            color: #4e596d;
            font-size: 0.95rem;
            font-weight: 600;
            text-overflow: ellipsis;
            text-align: center;
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

        .dedicated-node-buy,
        .dedicated-node-renew {
            min-width: 108px;
            padding: 11px 22px;
            border-radius: 8px;
            font-weight: 700;
        }

        .btn.dedicated-node-renew {
            color: #4269c4;
            background-color: #f2f6ff;
            border-color: #b9c9f4;
        }

        .btn.dedicated-node-renew:hover:not(.btn-text),
        .btn.dedicated-node-renew:focus:not(.btn-text),
        .btn.dedicated-node-renew.focus {
            color: #fff;
            background-color: #5d7fe8;
            border-color: #5d7fe8;
        }

        .btn.dedicated-node-renew:not(:disabled):not(.disabled):active,
        .btn.dedicated-node-renew:not(:disabled):not(.disabled).active {
            color: #fff;
            background-color: #4d6fd6;
            border-color: #4d6fd6;
        }

        .dedicated-node-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 24px;
            padding: 14px 16px;
            background: rgba(247, 249, 252, 0.86);
            border: 1px solid #e6ebf1;
            border-radius: 8px;
        }

        .dedicated-node-filter-controls {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .dedicated-node-filter-label {
            margin: 0 2px 0 0;
            color: #7b8697;
            font-size: 0.82rem;
            font-weight: 600;
        }

        .dedicated-node-country-filters {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .dedicated-node-filter-chip,
        .dedicated-node-owned-filter {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 40px;
            padding: 0 13px;
            color: #5d6a7c;
            background: #fff;
            border: 1px solid #dfe5ec;
            border-radius: 6px;
            font-size: 0.84rem;
            font-weight: 600;
        }

        .dedicated-node-filter-chip:hover,
        .dedicated-node-filter-chip:focus,
        .dedicated-node-owned-filter:hover,
        .dedicated-node-owned-filter:focus {
            color: #4269c4;
            background: #f2f6ff;
            border-color: #b9c9f4;
        }

        .dedicated-node-filter-chip.is-active,
        .dedicated-node-owned-filter.is-active {
            color: #fff;
            background: #5d7fe8;
            border-color: #5d7fe8;
        }

        .dedicated-node-filter-chip-count {
            min-width: 20px;
            margin-left: 6px;
            padding: 2px 5px;
            color: #8490a1;
            background: #eef2f7;
            border-radius: 10px;
            font-size: 0.72rem;
            line-height: 1.2;
            text-align: center;
        }

        .dedicated-node-filter-chip.is-active .dedicated-node-filter-chip-count {
            color: #5d7fe8;
            background: rgba(255, 255, 255, 0.9);
        }

        .dedicated-node-owned-filter i {
            margin-right: 6px;
        }

        .dedicated-node-owned-view {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 40px;
            padding: 0 14px;
            color: #fff;
            background: #20c7c7;
            border: 1px solid #20c7c7;
            border-radius: 6px;
            font-size: 0.84rem;
            font-weight: 600;
        }

        .dedicated-node-owned-view:hover,
        .dedicated-node-owned-view:focus {
            color: #fff;
            background: #18b5b5;
            border-color: #18b5b5;
        }

        .dedicated-node-owned-view i {
            margin-right: 6px;
        }

        .dedicated-node-filter-summary {
            flex: 0 0 auto;
            color: #9aa4b3;
            font-size: 0.82rem;
        }

        .dedicated-node-filter-empty {
            padding: 42px 20px;
            color: #8993a4;
            text-align: center;
        }

        .dedicated-node-filter-empty strong {
            display: block;
            margin-bottom: 6px;
            color: #556074;
            font-size: 1rem;
        }

        .dedicated-owned-modal .modal-dialog {
            max-width: 760px;
        }

        .dedicated-owned-modal .modal-content {
            overflow: hidden;
            border: 0;
            box-shadow: 0 20px 48px rgba(31, 45, 61, 0.18);
        }

        .dedicated-owned-modal .modal-header {
            align-items: center;
            padding: 22px 26px 18px;
            border-bottom: 1px solid #e9edf2;
        }

        .dedicated-owned-modal .modal-title {
            color: #3f4960;
            font-size: 1.2rem;
        }

        .dedicated-owned-count {
            margin-left: 9px;
            vertical-align: middle;
        }

        .dedicated-owned-modal .modal-body {
            max-height: 68vh;
            padding: 20px 26px 24px;
            overflow-y: auto;
            background: #f7f9fc;
        }

        .dedicated-owned-list {
            display: grid;
            gap: 14px;
        }

        .dedicated-owned-item {
            padding: 18px;
            background: #fff;
            border: 1px solid #e5eaf0;
            border-radius: 8px;
        }

        .dedicated-owned-node-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            margin-bottom: 18px;
        }

        .dedicated-owned-node-identity {
            display: flex;
            align-items: center;
            min-width: 0;
            gap: 12px;
        }

        .dedicated-owned-flag {
            flex: 0 0 auto;
            width: 42px;
            height: 42px;
            box-shadow: 0 4px 10px rgba(31, 45, 61, 0.1);
        }

        .dedicated-owned-node-copy {
            min-width: 0;
        }

        .dedicated-owned-node-name {
            margin: 0 0 4px;
            overflow: hidden;
            color: #3f4960;
            font-size: 1rem;
            line-height: 1.35;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .dedicated-owned-node-ip {
            overflow: hidden;
            color: #8b95a5;
            font-size: 0.82rem;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .dedicated-owned-expire {
            flex: 0 0 auto;
            color: #687386;
            font-size: 0.82rem;
            text-align: right;
            white-space: nowrap;
        }

        .dedicated-owned-expire strong {
            display: block;
            margin-top: 2px;
            color: #4e596d;
            font-weight: 600;
        }

        .dedicated-owned-remaining {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 10px;
        }

        .dedicated-owned-remaining-label {
            color: #7c8798;
            font-size: 0.82rem;
            font-weight: 600;
        }

        .dedicated-owned-remaining-value {
            color: #3699ff;
            font-size: 1.25rem;
            font-weight: 700;
            line-height: 1;
        }

        .dedicated-owned-progress {
            height: 7px;
            margin-bottom: 14px;
            overflow: hidden;
            background: #e9edf3;
            border-radius: 7px;
        }

        .dedicated-owned-progress-bar {
            height: 100%;
            background: #3699ff;
            border-radius: inherit;
        }

        .dedicated-owned-traffic-metrics {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 8px;
        }

        .dedicated-owned-traffic-metric {
            min-width: 0;
            padding: 10px 12px;
            background: #f8fafc;
            border-radius: 6px;
        }

        .dedicated-owned-traffic-label {
            display: block;
            margin-bottom: 3px;
            color: #9aa4b3;
            font-size: 0.72rem;
        }

        .dedicated-owned-traffic-value {
            display: block;
            color: #556074;
            font-size: 0.88rem;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        .dedicated-owned-unlimited {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            padding: 12px 14px;
            color: #687386;
            background: #f1f8ff;
            border-radius: 7px;
        }

        .dedicated-owned-unlimited strong {
            color: #3699ff;
        }

        .dedicated-owned-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 16px;
        }

        .dedicated-owned-action {
            min-width: 92px;
            border-radius: 6px;
            font-weight: 600;
        }

        .dedicated-owned-action i {
            margin-right: 5px;
        }

        .dedicated-owned-renew {
            min-width: 96px;
            border-radius: 6px;
            font-weight: 600;
        }

        .dedicated-config-modal .modal-dialog {
            max-width: 720px;
        }

        .dedicated-qr-modal .modal-dialog {
            max-width: 420px;
        }

        .dedicated-config-modal .modal-content,
        .dedicated-qr-modal .modal-content {
            overflow: hidden;
            border: 0;
            box-shadow: 0 20px 48px rgba(31, 45, 61, 0.18);
        }

        .dedicated-config-modal .modal-header,
        .dedicated-qr-modal .modal-header {
            align-items: center;
            padding: 22px 26px 18px;
            border-bottom: 1px solid #e9edf2;
        }

        .dedicated-config-modal .modal-title,
        .dedicated-qr-modal .modal-title {
            min-width: 0;
            color: #3f4960;
            font-size: 1.2rem;
            overflow-wrap: anywhere;
        }

        .dedicated-config-modal .modal-body {
            padding: 22px 26px 24px;
            background: #f7f9fc;
        }

        .dedicated-config-meta {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 14px;
        }

        .dedicated-config-protocol {
            color: #3699ff;
            font-size: 0.82rem;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .dedicated-config-status {
            min-height: 20px;
            margin: 0;
            color: #7c8798;
            font-size: 0.82rem;
            text-align: right;
        }

        .dedicated-config-url-box {
            padding: 14px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
        }

        .dedicated-config-url-label {
            display: block;
            margin-bottom: 8px;
            color: #7c8798;
            font-size: 0.78rem;
            font-weight: 600;
        }

        .dedicated-config-url {
            display: block;
            width: 100%;
            min-height: 76px;
            padding: 10px 12px;
            color: #4e596d;
            background: #f8fafc;
            border: 1px solid #e5eaf0;
            border-radius: 6px;
            font-family: SFMono-Regular, Consolas, monospace;
            font-size: 0.78rem;
            line-height: 1.55;
            resize: vertical;
        }

        .dedicated-config-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 12px;
        }

        .dedicated-config-action {
            min-width: 132px;
            border-radius: 6px;
            font-weight: 600;
        }

        .dedicated-config-action i {
            margin-right: 5px;
        }

        .dedicated-config-details {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 8px;
            margin-top: 16px;
        }

        .dedicated-config-detail {
            min-width: 0;
            padding: 10px 12px;
            background: #fff;
            border: 1px solid #e5eaf0;
            border-radius: 6px;
        }

        .dedicated-config-detail-label,
        .dedicated-config-detail-value {
            display: block;
            overflow-wrap: anywhere;
        }

        .dedicated-config-detail-label {
            margin-bottom: 3px;
            color: #9aa4b3;
            font-size: 0.72rem;
        }

        .dedicated-config-detail-value {
            color: #556074;
            font-family: SFMono-Regular, Consolas, monospace;
            font-size: 0.82rem;
            font-weight: 600;
        }

        .dedicated-config-loading {
            padding: 38px 20px;
            color: #8993a4;
            text-align: center;
        }

        .dedicated-qr-modal .modal-body {
            padding: 26px;
            background: #f7f9fc;
            text-align: center;
        }

        .dedicated-qr-hint {
            margin: 0 0 16px;
            color: #7c8798;
            font-size: 0.84rem;
        }

        .dedicated-qr-code {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 250px;
            min-height: 250px;
            padding: 12px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
        }

        .dedicated-qr-code canvas,
        .dedicated-qr-code img {
            display: block;
            max-width: 100%;
        }

        .dedicated-qr-fallback {
            max-width: 280px;
            color: #7c8798;
            font-size: 0.84rem;
            line-height: 1.6;
        }

        .dedicated-qr-url {
            display: block;
            max-width: 100%;
            margin-top: 14px;
            color: #8b95a5;
            font-family: SFMono-Regular, Consolas, monospace;
            font-size: 0.74rem;
            overflow-wrap: anywhere;
        }

        .dedicated-owned-empty {
            padding: 38px 20px;
            color: #8993a4;
            text-align: center;
        }

        .dedicated-owned-empty strong {
            display: block;
            margin-bottom: 6px;
            color: #556074;
            font-size: 1rem;
        }

        .dedicated-owned-modal .modal-footer {
            padding: 14px 26px 18px;
            border-top: 1px solid #e9edf2;
        }

        .dedicated-confirm-modal .modal-dialog {
            max-width: 460px;
        }

        .dedicated-confirm-modal .modal-content {
            overflow: hidden;
            border: 0;
            box-shadow: 0 20px 48px rgba(31, 45, 61, 0.2);
        }

        .dedicated-confirm-modal .modal-header {
            align-items: center;
            padding: 24px 26px 16px;
            border-bottom: 0;
        }

        .dedicated-confirm-heading {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .dedicated-confirm-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            color: #5d7fe8;
            background: #eef3ff;
            border-radius: 50%;
        }

        .dedicated-confirm-modal .modal-title {
            margin: 0;
            color: #3f4960;
            font-size: 1.2rem;
        }

        .dedicated-confirm-modal .modal-body {
            padding: 0 26px 22px;
        }

        .dedicated-confirm-lead {
            margin: 0 0 10px;
            color: #7b8697;
            font-size: 0.88rem;
        }

        .dedicated-confirm-node {
            display: flex;
            align-items: center;
            min-height: 48px;
            padding: 12px 14px;
            color: #3f4960;
            background: #f7f9fc;
            border: 1px solid #e6ebf2;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 700;
            overflow-wrap: anywhere;
        }

        .dedicated-confirm-warning {
            display: flex;
            align-items: flex-start;
            gap: 9px;
            margin: 14px 0 0;
            padding: 11px 12px;
            color: #687386;
            background: #fff8e8;
            border: 1px solid #f6e4b6;
            border-radius: 7px;
            font-size: 0.84rem;
            line-height: 1.55;
        }

        .dedicated-confirm-warning i {
            flex: 0 0 auto;
            margin-top: 3px;
            color: #d99b18;
        }

        .dedicated-confirm-modal .modal-footer {
            justify-content: flex-end;
            gap: 10px;
            padding: 16px 26px 22px;
            border-top: 1px solid #edf0f4;
        }

        .btn.dedicated-confirm-cancel,
        .btn.dedicated-confirm-submit {
            min-width: 96px;
            border-radius: 7px;
            font-weight: 600;
        }

        .btn.dedicated-confirm-cancel {
            color: #687386;
            background-color: #f1f4f7;
            border-color: #e1e6ec;
        }

        .btn.dedicated-confirm-cancel:hover,
        .btn.dedicated-confirm-cancel:focus {
            color: #4e596d;
            background-color: #e6ebf0;
            border-color: #d7dee7;
        }

        @media (max-width: 479.98px) {
            .dedicated-confirm-modal .modal-dialog {
                margin: 10px;
            }

            .dedicated-confirm-modal .modal-header,
            .dedicated-confirm-modal .modal-body,
            .dedicated-confirm-modal .modal-footer {
                padding-left: 18px;
                padding-right: 18px;
            }
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

            .dedicated-node-toolbar {
                align-items: flex-start;
                flex-direction: column;
            }

            .dedicated-node-filter-controls {
                width: 100%;
            }

            .dedicated-node-country-filters {
                width: 100%;
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

            .dedicated-owned-modal .modal-dialog {
                margin: 10px;
            }

            .dedicated-owned-modal .modal-header,
            .dedicated-owned-modal .modal-body,
            .dedicated-owned-modal .modal-footer {
                padding-left: 16px;
                padding-right: 16px;
            }

            .dedicated-owned-node-header {
                align-items: flex-start;
                flex-direction: column;
            }

            .dedicated-owned-node-name {
                white-space: normal;
            }

            .dedicated-owned-expire {
                padding-left: 54px;
                text-align: left;
            }

            .dedicated-owned-expire strong {
                display: inline;
                margin-left: 4px;
            }

            .dedicated-owned-traffic-metric {
                padding: 9px 8px;
            }

            .dedicated-config-details {
                grid-template-columns: 1fr;
            }

            .dedicated-config-action,
            .dedicated-owned-action {
                flex: 1 1 130px;
            }

            .dedicated-config-modal .modal-header,
            .dedicated-config-modal .modal-body,
            .dedicated-config-modal .modal-footer,
            .dedicated-qr-modal .modal-header,
            .dedicated-qr-modal .modal-body,
            .dedicated-qr-modal .modal-footer {
                padding-left: 16px;
                padding-right: 16px;
            }

            .dedicated-qr-code {
                min-width: 0;
                width: 100%;
            }
        }

    </style>
    {include file='include/global/head.tpl'}
    {if $theme_style === 'dark'}
    <style>
        /* 专用节点页使用与 Metron 深色主题一致的层级色，避免浅色页面样式覆盖深色基底。 */
        #kt_body {
            --dedicated-bg: #18191a;
            --dedicated-surface: #242526;
            --dedicated-surface-raised: #2d2f31;
            --dedicated-input: #3a3b3c;
            --dedicated-border: #3a3b3c;
            --dedicated-text: #ecf0f3;
            --dedicated-text-muted: #b5b5c3;
            --dedicated-text-soft: #8f98a6;
        }

        .dedicated-node-card {
            background-color: var(--dedicated-surface);
            border-color: var(--dedicated-border);
            box-shadow: 0 12px 28px rgba(0, 0, 0, 0.22);
        }

        .dedicated-node-card:hover {
            box-shadow: 0 16px 34px rgba(0, 0, 0, 0.32);
        }

        .dedicated-node-header {
            background: rgba(58, 59, 60, 0.62);
            border-bottom-color: var(--dedicated-border);
        }

        .dedicated-node-title,
        .dedicated-node-price-value {
            color: var(--dedicated-text);
        }

        .dedicated-node-type,
        .dedicated-node-description,
        .dedicated-node-price-line {
            color: var(--dedicated-text-muted);
        }

        .dedicated-node-empty-description,
        .dedicated-node-term {
            color: var(--dedicated-text-soft);
        }

        .dedicated-node-fact {
            background: var(--dedicated-input);
        }

        .dedicated-node-fact-icon {
            background: rgba(105, 147, 255, 0.2);
            color: #9eb8ff;
        }

        .dedicated-node-fact-label,
        .dedicated-node-filter-label,
        .dedicated-node-filter-summary,
        .dedicated-node-unlock-title,
        .dedicated-node-unlock-item,
        .dedicated-node-unlock-heading .text-muted {
            color: var(--dedicated-text-muted) !important;
        }

        .dedicated-node-fact-value {
            color: var(--dedicated-text);
        }

        .dedicated-node-unlock,
        .dedicated-node-footer {
            border-color: var(--dedicated-border);
        }

        .btn.dedicated-node-renew {
            color: #b8caff;
            background-color: rgba(105, 147, 255, 0.16);
            border-color: rgba(105, 147, 255, 0.58);
        }

        .btn.dedicated-node-renew:hover:not(.btn-text),
        .btn.dedicated-node-renew:focus:not(.btn-text),
        .btn.dedicated-node-renew.focus {
            color: #fff;
            background-color: #6993ff;
            border-color: #6993ff;
        }

        .dedicated-node-state.label-light-primary {
            color: #b8caff !important;
            background-color: rgba(105, 147, 255, 0.18) !important;
            border-color: rgba(105, 147, 255, 0.35) !important;
        }

        .dedicated-node-state.label-secondary {
            color: var(--dedicated-text-muted) !important;
            background-color: var(--dedicated-input) !important;
            border-color: var(--dedicated-border) !important;
        }

        .dedicated-node-toolbar {
            background: rgba(36, 37, 38, 0.94);
            border-color: var(--dedicated-border);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }

        .dedicated-node-filter-chip,
        .dedicated-node-owned-filter {
            color: var(--dedicated-text-muted);
            background: var(--dedicated-input);
            border-color: #4a4b4d;
        }

        .dedicated-node-filter-chip:hover,
        .dedicated-node-filter-chip:focus,
        .dedicated-node-owned-filter:hover,
        .dedicated-node-owned-filter:focus {
            color: #c6d4ff;
            background: rgba(105, 147, 255, 0.18);
            border-color: rgba(105, 147, 255, 0.6);
        }

        .dedicated-node-filter-chip-count {
            color: var(--dedicated-text-muted);
            background: var(--dedicated-surface-raised);
        }

        .dedicated-node-filter-chip.is-active .dedicated-node-filter-chip-count {
            color: #527bea;
            background: rgba(255, 255, 255, 0.9);
        }

        .dedicated-node-filter-empty,
        .dedicated-node-filter-empty strong {
            color: var(--dedicated-text-muted);
        }

        .dedicated-node-filter-empty strong {
            color: var(--dedicated-text);
        }

        #kt_body .dedicated-node-empty-alert {
            color: var(--dedicated-text-muted);
            background-color: var(--dedicated-surface);
            border-color: var(--dedicated-border);
        }

        .dedicated-owned-modal .modal-content,
        .dedicated-config-modal .modal-content,
        .dedicated-qr-modal .modal-content,
        .dedicated-confirm-modal .modal-content,
        .dedicated-payment-modal .modal-content {
            color: var(--dedicated-text);
            background-color: var(--dedicated-surface);
            box-shadow: 0 20px 48px rgba(0, 0, 0, 0.38);
        }

        .dedicated-owned-modal .modal-header,
        .dedicated-config-modal .modal-header,
        .dedicated-qr-modal .modal-header,
        .dedicated-confirm-modal .modal-header,
        .dedicated-payment-modal .modal-header,
        .dedicated-owned-modal .modal-footer,
        .dedicated-confirm-modal .modal-footer,
        .dedicated-payment-modal .modal-footer {
            border-color: var(--dedicated-border);
        }

        .dedicated-owned-modal .modal-title,
        .dedicated-config-modal .modal-title,
        .dedicated-qr-modal .modal-title,
        .dedicated-confirm-modal .modal-title,
        .dedicated-payment-modal .modal-title,
        .dedicated-owned-node-name,
        .dedicated-confirm-node,
        .dedicated-payment-summary {
            color: var(--dedicated-text);
        }

        /* Metron 的 modal 标题选择器优先级更高，专用节点弹窗需要显式覆盖。 */
        body#kt_body .dedicated-owned-modal .modal-header .modal-title {
            color: var(--dedicated-text) !important;
        }

        body#kt_body .dedicated-owned-modal .dedicated-owned-count {
            color: #b8caff !important;
            background-color: rgba(105, 147, 255, 0.18) !important;
            border: 1px solid rgba(105, 147, 255, 0.35);
        }

        body#kt_body .dedicated-owned-modal .modal-footer .btn.btn-secondary {
            color: var(--dedicated-text) !important;
            background-color: var(--dedicated-input) !important;
            border-color: #4a4b4d !important;
        }

        body#kt_body .dedicated-owned-modal .modal-footer .btn.btn-secondary:hover,
        body#kt_body .dedicated-owned-modal .modal-footer .btn.btn-secondary:focus {
            color: #fff !important;
            background-color: #4a4b4d !important;
            border-color: #626468 !important;
        }

        .dedicated-owned-modal .modal-body,
        .dedicated-config-modal .modal-body,
        .dedicated-qr-modal .modal-body {
            background: var(--dedicated-bg);
        }

        .dedicated-owned-item,
        .dedicated-config-url-box,
        .dedicated-config-detail {
            background: var(--dedicated-surface);
            border-color: var(--dedicated-border);
        }

        .dedicated-owned-node-ip,
        .dedicated-owned-expire,
        .dedicated-owned-remaining-label,
        .dedicated-owned-traffic-label,
        .dedicated-config-url-label,
        .dedicated-config-status,
        .dedicated-config-loading,
        .dedicated-qr-hint,
        .dedicated-qr-fallback,
        .dedicated-qr-url,
        .dedicated-owned-empty,
        .dedicated-confirm-lead,
        .dedicated-payment-hint {
            color: var(--dedicated-text-muted);
        }

        .dedicated-owned-empty strong {
            color: var(--dedicated-text);
        }

        .dedicated-owned-expire strong,
        .dedicated-owned-traffic-value,
        .dedicated-config-detail-value {
            color: var(--dedicated-text);
        }

        .dedicated-owned-progress,
        .dedicated-owned-traffic-metric {
            background: var(--dedicated-input);
        }

        .dedicated-owned-unlimited {
            color: var(--dedicated-text-muted);
            background: rgba(54, 153, 255, 0.14);
        }

        .dedicated-payment-qr {
            background: var(--dedicated-input);
        }

        .dedicated-config-url {
            color: var(--dedicated-text);
            background: var(--dedicated-input);
            border-color: #4a4b4d;
        }

        .dedicated-confirm-node {
            background: var(--dedicated-input);
            border-color: #4a4b4d;
        }

        .dedicated-confirm-icon {
            color: #a9bdff;
            background: rgba(105, 147, 255, 0.18);
        }

        .dedicated-confirm-warning {
            color: #e3c47c;
            background: rgba(255, 168, 0, 0.12);
            border-color: rgba(255, 168, 0, 0.34);
        }

        .btn.dedicated-confirm-cancel,
        .dedicated-pay-balance.btn {
            color: var(--dedicated-text-muted);
            background-color: var(--dedicated-input);
            border-color: #4a4b4d;
        }

        .btn.dedicated-confirm-cancel:hover,
        .btn.dedicated-confirm-cancel:focus,
        .dedicated-pay-balance.btn:hover:not(:disabled),
        .dedicated-pay-balance.btn:focus:not(:disabled) {
            color: var(--dedicated-text);
            background-color: #4a4b4d;
            border-color: #626468;
        }

        .dedicated-pay-option.btn-light-primary,
        .dedicated-owned-action.btn-light-primary {
            color: #b8caff;
            background-color: rgba(105, 147, 255, 0.16);
            border-color: rgba(105, 147, 255, 0.45);
        }

        .dedicated-pay-option.btn-light-success,
        .dedicated-owned-action.btn-light-success {
            color: #8be5dc;
            background-color: rgba(27, 197, 189, 0.14);
            border-color: rgba(27, 197, 189, 0.42);
        }

        .dedicated-pay-option.btn-light-info,
        .dedicated-owned-action.btn-light-info {
            color: #c2aaff;
            background-color: rgba(137, 80, 252, 0.14);
            border-color: rgba(137, 80, 252, 0.42);
        }

        .dedicated-pay-option.btn-light-warning {
            color: #f1cf83;
            background-color: rgba(255, 168, 0, 0.14);
            border-color: rgba(255, 168, 0, 0.42);
        }

        .dedicated-pay-option.btn-light-primary:hover,
        .dedicated-pay-option.btn-light-primary:focus,
        .dedicated-owned-action.btn-light-primary:hover,
        .dedicated-owned-action.btn-light-primary:focus {
            color: #fff;
            background-color: #6993ff;
            border-color: #6993ff;
        }

        .dedicated-pay-option.btn-light-success:hover,
        .dedicated-pay-option.btn-light-success:focus,
        .dedicated-owned-action.btn-light-success:hover,
        .dedicated-owned-action.btn-light-success:focus {
            color: #fff;
            background-color: #1bc5bd;
            border-color: #1bc5bd;
        }

        .dedicated-pay-option.btn-light-info:hover,
        .dedicated-pay-option.btn-light-info:focus,
        .dedicated-owned-action.btn-light-info:hover,
        .dedicated-owned-action.btn-light-info:focus {
            color: #fff;
            background-color: #8950fc;
            border-color: #8950fc;
        }

        .dedicated-pay-option.btn-light-warning:hover,
        .dedicated-pay-option.btn-light-warning:focus {
            color: #fff;
            background-color: #ffa800;
            border-color: #ffa800;
        }

        #dedicated-payment-result.alert-light,
        .dedicated-payment-result.alert-light {
            color: var(--dedicated-text-muted);
            background-color: var(--dedicated-input);
            border-color: var(--dedicated-border);
        }
    </style>
    {/if}
    <div class="d-flex flex-column flex-root">
        <div class="d-flex flex-row flex-column-fluid page">
            <div class="d-flex flex-column flex-row-fluid wrapper" id="kt_wrapper">
                {include file='include/global/menu.tpl'}
                <div class="content d-flex flex-column flex-column-fluid" id="kt_content">
                    <div class="subheader min-h-lg-175px pt-5 pb-7 subheader-transparent" id="kt_subheader">
                        <div class="container d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
                            <div class="d-flex align-items-center flex-wrap mr-2">
                                <div class="d-flex flex-column">
                                    <h2 class="text-white font-weight-bold my-2 mr-5">专用节点</h2>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <button type="button" data-toggle="modal" data-target="#dedicated-owned-modal"
                                        class="btn {$style[$theme_style]['global']['btn_subheader']} font-weight-bold py-3 px-6 dedicated-node-view-button">我的专用节点{if $dedicated_owned_count > 0} · {$dedicated_owned_count}{/if}</button>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex flex-column-fluid">
                        <div class="container">
                            <div class="dedicated-node-toolbar" role="region" aria-label="专用节点筛选">
                                <div class="dedicated-node-filter-controls">
                                    <span class="dedicated-node-filter-label">国家/地区</span>
                                    <div id="dedicated-country-filters" class="dedicated-node-country-filters" role="group" aria-label="国家/地区筛选">
                                        <button type="button" class="dedicated-node-filter-chip is-active" data-country-filter="" aria-pressed="true">
                                            全部<span class="dedicated-node-filter-chip-count">{$dedicated_nodes|count}</span>
                                        </button>
                                        {foreach $dedicated_countries as $countryCode => $countryName}
                                            <button type="button" class="dedicated-node-filter-chip" data-country-filter="{$countryCode|escape:'htmlall'}" aria-pressed="false">
                                                {$countryName|escape:'htmlall'}<span class="dedicated-node-filter-chip-count">{$dedicated_country_counts[$countryCode]}</span>
                                            </button>
                                        {/foreach}
                                    </div>
                                    <button type="button" id="dedicated-owned-filter" class="btn dedicated-node-owned-filter" aria-pressed="false">
                                        <i class="fas fa-user-check" aria-hidden="true"></i>已拥有
                                    </button>
                                    <button type="button" class="btn dedicated-node-owned-view" data-toggle="modal" data-target="#dedicated-owned-modal">
                                        <i class="fas fa-list" aria-hidden="true"></i>我的专用节点{if $dedicated_owned_count > 0} · {$dedicated_owned_count}{/if}
                                    </button>
                                </div>
                                <span id="dedicated-filter-summary" class="dedicated-node-filter-summary" aria-live="polite"></span>
                            </div>
                            <div class="row" id="dedicated-node-grid">
                        {foreach $dedicated_nodes as $item}
                            {$node = $item['node']} {$access = $item['access']}
                            <div class="col-md-6 col-xl-4 mb-6 dedicated-node-card-wrap"
                                 data-country="{$item['country_code']|escape:'htmlall'}"
                                 data-owned="{if $access}1{else}0{/if}"
                                 data-occupied="{if $item['occupied']}1{else}0{/if}">
                                <div class="card card-custom h-100 dedicated-node-card">
                                    <div class="card-body d-flex flex-column dedicated-node-body">
                                        <div class="dedicated-node-header">
                                            <div class="dedicated-node-heading">
                                                <img alt="节点地区" class="rounded-circle dedicated-node-flag"
                                                     width="48" height="48"
                                                     src="{$metron['assets_url']}/media/flags/1x1/{$item['flag']}.svg">
                                                <div class="min-w-0">
                                                    <div class="dedicated-node-type">专用 IP 节点</div>
                                                    <div class="dedicated-node-title-line">
                                                        <span class="label label-dot label-xl dedicated-node-online-dot {if $item['online']}label-success{else}label-danger{/if}"
                                                              title="{if $item['online']}在线{else}离线{/if}"
                                                              aria-label="{if $item['online']}在线{else}离线{/if}"></span>
                                                        <h3 class="font-weight-bolder dedicated-node-title">{$node->name}</h3>
                                                    </div>
                                                </div>
                                            </div>
                                            {if $access}
                                                <span class="label label-inline label-success dedicated-node-state">已拥有</span>
                                            {elseif $item['occupied']}
                                                <span class="label label-inline label-secondary dedicated-node-state">已售出</span>
                                            {else}
                                                <span class="label label-inline label-light-primary dedicated-node-state">可购买</span>
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
                                                    <div class="dedicated-node-fact-heading">
                                                        <i class="fas fa-globe dedicated-node-fact-icon" aria-hidden="true"></i>
                                                        <span class="dedicated-node-fact-label">IP 地址</span>
                                                    </div>
                                                    <span class="dedicated-node-fact-value" title="{$node->getMaskedIp()}">{$node->getMaskedIp()}</span>
                                                </div>
                                                <div class="dedicated-node-fact">
                                                    <div class="dedicated-node-fact-heading">
                                                        <i class="fas fa-database dedicated-node-fact-icon" aria-hidden="true"></i>
                                                        <span class="dedicated-node-fact-label">专用流量</span>
                                                    </div>
                                                    <span class="dedicated-node-fact-value">{$item['dedicated_traffic_text']}</span>
                                                </div>
                                                <div class="dedicated-node-fact">
                                                    <div class="dedicated-node-fact-heading">
                                                        <i class="fas fa-calendar-alt dedicated-node-fact-icon" aria-hidden="true"></i>
                                                        <span class="dedicated-node-fact-label">授权周期</span>
                                                    </div>
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
                                            {if $item['occupied']}
                                                <span class="label label-inline label-secondary dedicated-node-state">已售出</span>
                                            {elseif $access}
                                                <button type="button" class="btn dedicated-node-renew" onclick="dedicatedRenew({$node->id}, '{$node->name|escape:'javascript'}', '{$node->dedicated_price}')">续费</button>
                                            {elseif !$access}
                                                <button type="button" class="btn btn-primary dedicated-node-buy" onclick="dedicatedBuy({$node->id}, '{$node->name|escape:'javascript'}', '{$node->dedicated_price}')">购买</button>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {foreachelse}
                            <div class="col-12">
                                <div class="alert alert-light dedicated-node-empty-alert d-flex align-items-center justify-content-between flex-wrap py-5 px-6">
                                    <span>暂无可购买的专用节点</span>
                                </div>
                            </div>
                        {/foreach}
                                <div class="col-12 dedicated-node-filter-empty" id="dedicated-filter-empty" style="display: none;">
                                    <strong>暂无符合条件的专用节点</strong>
                                    <span>可以更换国家/地区或关闭“已拥有”筛选。</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {include file='include/global/footer.tpl'}
            </div>
        </div>
    </div>
    {include file='include/global/scripts.tpl'}
    <div class="modal fade dedicated-owned-modal" id="dedicated-owned-modal" data-auto-open="{if $dedicated_open_owned}1{else}0{/if}" tabindex="-1" role="dialog" aria-labelledby="dedicated-owned-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dedicated-owned-title">
                        我的专用节点
                        {if $dedicated_owned_count > 0}<span class="label label-light-primary dedicated-owned-count">{$dedicated_owned_count}</span>{/if}
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    {if $dedicated_owned_nodes}
                        <div class="dedicated-owned-list">
                            {foreach $dedicated_owned_nodes as $ownedItem}
                                {$ownedNode = $ownedItem['node']} {$ownedAccess = $ownedItem['access']}
                                <section class="dedicated-owned-item">
                                    <div class="dedicated-owned-node-header">
                                        <div class="dedicated-owned-node-identity">
                                            <img alt="节点地区" class="rounded-circle dedicated-owned-flag"
                                                 width="42" height="42"
                                                 src="{$metron['assets_url']}/media/flags/1x1/{$ownedItem['flag']}.svg">
                                            <div class="dedicated-owned-node-copy">
                                                <h6 class="dedicated-owned-node-name">{$ownedNode->name}</h6>
                                                <div class="dedicated-owned-node-ip">IP {$ownedNode->getMaskedIp()}</div>
                                            </div>
                                        </div>
                                        <div class="dedicated-owned-expire">
                                            有效期至
                                            <strong>{$ownedItem['expire_text']}</strong>
                                        </div>
                                    </div>
                                    <div class="dedicated-owned-remaining">
                                        <span class="dedicated-owned-remaining-label">剩余专用流量</span>
                                        <strong class="dedicated-owned-remaining-value">{$ownedItem['traffic_remaining_text']}</strong>
                                    </div>
                                    {if $ownedAccess->traffic_limit > 0}
                                        <div class="dedicated-owned-progress" role="progressbar" aria-label="专用流量使用进度" aria-valuenow="{$ownedItem['traffic_percent']}" aria-valuemin="0" aria-valuemax="100">
                                            <div class="dedicated-owned-progress-bar" style="width: {$ownedItem['traffic_percent']}%;"></div>
                                        </div>
                                        <div class="dedicated-owned-traffic-metrics">
                                            <div class="dedicated-owned-traffic-metric">
                                                <span class="dedicated-owned-traffic-label">已用</span>
                                                <span class="dedicated-owned-traffic-value">{$ownedItem['traffic_used_text']}</span>
                                            </div>
                                            <div class="dedicated-owned-traffic-metric">
                                                <span class="dedicated-owned-traffic-label">总量</span>
                                                <span class="dedicated-owned-traffic-value">{$ownedItem['traffic_limit_text']}</span>
                                            </div>
                                            <div class="dedicated-owned-traffic-metric">
                                                <span class="dedicated-owned-traffic-label">剩余</span>
                                                <span class="dedicated-owned-traffic-value">{$ownedItem['traffic_remaining_text']}</span>
                                            </div>
                                        </div>
                                    {else}
                                        <div class="dedicated-owned-unlimited">
                                            <span>已用 {$ownedItem['traffic_used_text']}</span>
                                            <strong>总量不限</strong>
                                        </div>
                                    {/if}
                                    <div class="dedicated-owned-actions">
                                        <button type="button" class="btn btn-light-primary dedicated-owned-action" onclick="dedicatedNodeConfig({$ownedNode->id}, '{$ownedNode->name|escape:'javascript'}')" title="查看并复制该节点配置">
                                            <i class="fas fa-sliders-h" aria-hidden="true"></i>配置
                                        </button>
                                        <button type="button" class="btn btn-light-primary dedicated-owned-action" onclick="dedicatedNodeCopy({$ownedNode->id})" title="复制节点链接">
                                            <i class="fas fa-copy" aria-hidden="true"></i>复制
                                        </button>
                                        <button type="button" class="btn btn-light-info dedicated-owned-action" onclick="dedicatedNodeQr({$ownedNode->id}, '{$ownedNode->name|escape:'javascript'}')" title="显示节点二维码">
                                            <i class="fas fa-qrcode" aria-hidden="true"></i>二维码
                                        </button>
                                        <button type="button" class="btn btn-light-success dedicated-owned-action" onclick="dedicatedNodeShadowrocket({$ownedNode->id}, '{$ownedNode->name|escape:'javascript'}')" title="导入 Shadowrocket">
                                            <i class="fas fa-rocket" aria-hidden="true"></i>Shadowrocket
                                        </button>
                                        <button type="button" class="btn btn-outline-primary dedicated-owned-renew" onclick="dedicatedRenew({$ownedNode->id}, '{$ownedNode->name|escape:'javascript'}', '{$ownedNode->dedicated_price}')">续费</button>
                                    </div>
                                </section>
                            {/foreach}
                        </div>
                    {else}
                        <div class="dedicated-owned-empty">
                            <strong>暂无有效的专用节点</strong>
                            <span>购买成功后，节点和独立流量会显示在这里。</span>
                        </div>
                    {/if}
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade dedicated-config-modal" id="dedicated-config-modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dedicated-config-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dedicated-config-title">节点配置</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div id="dedicated-config-loading" class="dedicated-config-loading">
                        <i class="fas fa-circle-notch fa-spin mr-2" aria-hidden="true"></i>正在获取节点配置...
                    </div>
                    <div id="dedicated-config-content" style="display: none;">
                        <div class="dedicated-config-meta">
                            <span id="dedicated-config-protocol" class="dedicated-config-protocol"></span>
                            <span id="dedicated-config-status" class="dedicated-config-status" aria-live="polite"></span>
                        </div>
                        <div class="dedicated-config-url-box">
                            <span class="dedicated-config-url-label">节点链接（可粘贴到支持该协议的客户端）</span>
                            <textarea id="dedicated-config-url" class="dedicated-config-url" rows="3" readonly></textarea>
                        </div>
                        <div class="dedicated-config-actions">
                            <button type="button" class="btn btn-primary dedicated-config-action" id="dedicated-config-copy">
                                <i class="fas fa-copy" aria-hidden="true"></i>复制节点链接
                            </button>
                            <button type="button" class="btn btn-info dedicated-config-action" id="dedicated-config-qr">
                                <i class="fas fa-qrcode" aria-hidden="true"></i>显示二维码
                            </button>
                            <button type="button" class="btn btn-success dedicated-config-action" id="dedicated-config-shadowrocket">
                                <i class="fas fa-rocket" aria-hidden="true"></i>导入 Shadowrocket
                            </button>
                        </div>
                        <div id="dedicated-config-details" class="dedicated-config-details"></div>
                    </div>
                    <div id="dedicated-config-error" class="alert alert-danger" style="display: none;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade dedicated-qr-modal" id="dedicated-qr-modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dedicated-qr-title" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dedicated-qr-title">节点二维码</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <p class="dedicated-qr-hint">使用支持该协议的客户端扫描二维码添加节点</p>
                    <div id="dedicated-qr-code" class="dedicated-qr-code"></div>
                    <div id="dedicated-qr-fallback" class="dedicated-qr-fallback" style="display: none;"></div>
                    <code id="dedicated-qr-url" class="dedicated-qr-url"></code>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade dedicated-confirm-modal" id="dedicated-renew-confirm-modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="dedicated-renew-confirm-title" aria-describedby="dedicated-renew-confirm-description" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="dedicated-confirm-heading">
                        <span class="dedicated-confirm-icon" aria-hidden="true"><i class="fas fa-sync-alt"></i></span>
                        <h5 class="modal-title" id="dedicated-renew-confirm-title">确认续费</h5>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <p class="dedicated-confirm-lead">即将续费专用节点</p>
                    <div id="dedicated-renew-confirm-node" class="dedicated-confirm-node"></div>
                    <p class="dedicated-confirm-warning" id="dedicated-renew-confirm-description">
                        <i class="fas fa-exclamation-circle" aria-hidden="true"></i>
                        <span>续费后会覆盖当前有效期和专用流量，确认继续吗？</span>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn dedicated-confirm-cancel" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary dedicated-confirm-submit" id="dedicated-renew-confirm-submit">确认续费</button>
                </div>
            </div>
        </div>
    </div>
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
                        <div class="col-6 mb-3"><button type="button" class="btn btn-block dedicated-pay-option dedicated-pay-balance" data-type="balance" data-payment-mode="balance">余额支付（余额 {$user->money} 元）</button></div>
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
            var grid = document.getElementById('dedicated-node-grid');
            if (!grid) {
                return;
            }

            var cards = grid.querySelectorAll('.dedicated-node-card-wrap');
            var countryFilters = document.querySelectorAll('[data-country-filter]');
            var ownedFilter = document.getElementById('dedicated-owned-filter');
            var summary = document.getElementById('dedicated-filter-summary');
            var emptyState = document.getElementById('dedicated-filter-empty');
            var selectedCountry = '';

            function applyFilters() {
                var country = selectedCountry;
                var ownedOnly = ownedFilter && ownedFilter.getAttribute('aria-pressed') === 'true';
                var visibleCount = 0;

                Array.prototype.forEach.call(cards, function (card) {
                    var matchesCountry = !country || card.getAttribute('data-country') === country;
                    var matchesOwned = !ownedOnly || card.getAttribute('data-owned') === '1';
                    var visible = matchesCountry && matchesOwned;
                    card.classList.toggle('d-none', !visible);
                    card.setAttribute('aria-hidden', visible ? 'false' : 'true');
                    if (visible) {
                        visibleCount += 1;
                    }
                });

                if (summary) {
                    summary.textContent = '显示 ' + visibleCount + ' / ' + cards.length + ' 个节点';
                }
                if (emptyState) {
                    emptyState.style.display = cards.length > 0 && visibleCount === 0 ? '' : 'none';
                }
            }

            Array.prototype.forEach.call(countryFilters, function (filter) {
                filter.addEventListener('click', function () {
                    selectedCountry = filter.getAttribute('data-country-filter') || '';
                    Array.prototype.forEach.call(countryFilters, function (item) {
                        var active = item === filter;
                        item.setAttribute('aria-pressed', active ? 'true' : 'false');
                        item.classList.toggle('is-active', active);
                    });
                    applyFilters();
                });
            });
            if (ownedFilter) {
                ownedFilter.addEventListener('click', function () {
                    var active = ownedFilter.getAttribute('aria-pressed') !== 'true';
                    ownedFilter.setAttribute('aria-pressed', active ? 'true' : 'false');
                    ownedFilter.classList.toggle('is-active', active);
                    applyFilters();
                });
            }
            applyFilters();
        }());

        (function () {
            var configModal = document.getElementById('dedicated-config-modal');
            var qrModal = document.getElementById('dedicated-qr-modal');
            if (!configModal || !qrModal) {
                return;
            }

            var configLoading = document.getElementById('dedicated-config-loading');
            var configContent = document.getElementById('dedicated-config-content');
            var configError = document.getElementById('dedicated-config-error');
            var configTitle = document.getElementById('dedicated-config-title');
            var configProtocol = document.getElementById('dedicated-config-protocol');
            var configStatus = document.getElementById('dedicated-config-status');
            var configUrl = document.getElementById('dedicated-config-url');
            var configDetails = document.getElementById('dedicated-config-details');
            var configCopy = document.getElementById('dedicated-config-copy');
            var configQr = document.getElementById('dedicated-config-qr');
            var configShadowrocket = document.getElementById('dedicated-config-shadowrocket');
            var qrTitle = document.getElementById('dedicated-qr-title');
            var qrCode = document.getElementById('dedicated-qr-code');
            var qrFallback = document.getElementById('dedicated-qr-fallback');
            var qrUrl = document.getElementById('dedicated-qr-url');
            var configCache = {};
            var currentConfig = null;

            var protocolNames = {
                0: 'SS / SSR',
                1: 'Shadowsocks 2022',
                10: 'SS / SSR',
                11: 'VMess',
                12: 'VMess',
                13: 'V2Ray Plugin',
                14: 'Trojan',
                15: 'VLESS',
                16: 'VLESS Reality',
                17: 'Hysteria2',
                18: 'AnyTLS'
            };

            var fieldDefinitions = [
                {keys: ['address', 'add'], label: '服务器地址'},
                {keys: ['port'], label: '服务器端口'},
                {keys: ['method'], label: '加密方式'},
                {keys: ['passwd'], label: '密码'},
                {keys: ['password'], label: '密码'},
                {keys: ['protocol'], label: '协议'},
                {keys: ['protocol_param'], label: '协议参数'},
                {keys: ['obfs'], label: '混淆'},
                {keys: ['obfs_param'], label: '混淆参数'},
                {keys: ['net'], label: '传输协议'},
                {keys: ['path'], label: '路径'},
                {keys: ['host'], label: '伪装域名'},
                {keys: ['headerType'], label: '请求头类型'},
                {keys: ['security'], label: '安全类型'},
                {keys: ['tls'], label: 'TLS'},
                {keys: ['flow'], label: '流控'},
                {keys: ['serverName', 'sni'], label: 'SNI'},
                {keys: ['fp'], label: '指纹'},
                {keys: ['publicKey', 'pbk'], label: '公钥'},
                {keys: ['shortId', 'sid'], label: '短 ID'},
                {keys: ['up_mbps'], label: '上行速率'},
                {keys: ['down_mbps'], label: '下行速率'},
                {keys: ['server_name'], label: 'Server Name'},
                {keys: ['allow_insecure', 'insecure'], label: '跳过证书验证'},
                {keys: ['padding_scheme'], label: '填充方案'}
            ];

            function showModal(element) {
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery(element).modal('show');
                    return;
                }
                element.style.display = 'block';
                element.classList.add('show');
                element.setAttribute('aria-hidden', 'false');
            }

            function hideModal(element) {
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery(element).modal('hide');
                    return;
                }
                element.style.display = 'none';
                element.classList.remove('show');
                element.setAttribute('aria-hidden', 'true');
            }

            function setConfigState(isLoading, errorMessage) {
                configLoading.style.display = isLoading ? '' : 'none';
                configContent.style.display = !isLoading && !errorMessage ? '' : 'none';
                configError.style.display = errorMessage ? '' : 'none';
                configError.textContent = errorMessage || '';
            }

            function fetchConfig(nodeId) {
                var cacheKey = String(nodeId);
                if (configCache[cacheKey]) {
                    return Promise.resolve(configCache[cacheKey]);
                }

                return fetch('/user/nodeinfo/' + encodeURIComponent(nodeId), {
                    method: 'GET',
                    credentials: 'same-origin',
                    headers: {'Accept': 'application/json'}
                }).then(function (response) {
                    return response.text().then(function (text) {
                        var data = null;
                        try {
                            data = JSON.parse(text);
                        } catch (error) {
                            throw new Error('节点配置响应格式错误');
                        }
                        if (!response.ok || !data || parseInt(data.ret, 10) !== 1) {
                            throw new Error((data && data.msg) || '无法获取节点配置');
                        }
                        configCache[cacheKey] = data;
                        return data;
                    });
                });
            }

            function getNodeUrl(data) {
                return (data && (data.url || data.sslink || data.ssrlink)) || '';
            }

            function getShadowrocketUrl(data) {
                return (data && (data.shadowrocket_url || getNodeUrl(data))) || '';
            }

            function formatDetailValue(value) {
                if (value === true) {
                    return '是';
                }
                if (value === false) {
                    return '否';
                }
                if (value && typeof value === 'object') {
                    try {
                        return JSON.stringify(value);
                    } catch (error) {
                        return String(value);
                    }
                }
                return String(value);
            }

            function appendDetail(label, value) {
                var item = document.createElement('div');
                var itemLabel = document.createElement('span');
                var itemValue = document.createElement('span');
                item.className = 'dedicated-config-detail';
                itemLabel.className = 'dedicated-config-detail-label';
                itemValue.className = 'dedicated-config-detail-value';
                itemLabel.textContent = label;
                itemValue.textContent = formatDetailValue(value);
                item.appendChild(itemLabel);
                item.appendChild(itemValue);
                configDetails.appendChild(item);
            }

            function renderDetails(info) {
                configDetails.innerHTML = '';
                var usedLabels = {};
                var isV2 = info && (info.type === 'vmess' || info.type === 'vless');
                if (isV2 && info.id) {
                    appendDetail('用户 UUID', info.id);
                }
                fieldDefinitions.forEach(function (definition) {
                    var key = null;
                    definition.keys.some(function (candidate) {
                        if (Object.prototype.hasOwnProperty.call(info, candidate)
                            && info[candidate] !== null && info[candidate] !== '') {
                            key = candidate;
                            return true;
                        }
                        return false;
                    });
                    if (!key || usedLabels[definition.label]) {
                        return;
                    }
                    usedLabels[definition.label] = true;
                    appendDetail(definition.label, info[key]);
                });
                if (!configDetails.children.length) {
                    appendDetail('配置', '请直接使用上方节点链接导入');
                }
            }

            function renderConfig(data, nodeName) {
                var info = data.info || {};
                var url = getNodeUrl(data);
                var protocol = data.protocol || protocolNames[parseInt(data.sort, 10)] || info.type || '节点';
                currentConfig = data;
                configTitle.textContent = nodeName + ' · 节点配置';
                configProtocol.textContent = protocol;
                configStatus.textContent = '已通过当前账号授权';
                configUrl.value = url;
                renderDetails(info);
                configShadowrocket.disabled = !getShadowrocketUrl(data);
                setConfigState(false, url ? '' : '该节点暂时没有可用的节点链接');
            }

            function showMessage(message, isError) {
                if (window.Swal && typeof window.Swal.fire === 'function') {
                    window.Swal.fire({
                        icon: isError ? 'error' : 'success',
                        title: message,
                        timer: 1400,
                        showConfirmButton: false
                    });
                    return;
                }
                configStatus.textContent = message;
                configStatus.style.color = isError ? '#f64e60' : '#1bc5bd';
            }

            function copyText(text) {
                if (!text) {
                    return Promise.reject(new Error('没有可复制的节点链接'));
                }
                if (navigator.clipboard && window.isSecureContext) {
                    return navigator.clipboard.writeText(text);
                }
                return new Promise(function (resolve, reject) {
                    var textarea = document.createElement('textarea');
                    textarea.value = text;
                    textarea.setAttribute('readonly', 'readonly');
                    textarea.style.position = 'fixed';
                    textarea.style.opacity = '0';
                    document.body.appendChild(textarea);
                    textarea.focus();
                    textarea.select();
                    var copied = false;
                    try {
                        copied = document.execCommand('copy');
                    } catch (error) {
                        copied = false;
                    }
                    document.body.removeChild(textarea);
                    if (copied) {
                        resolve();
                    } else {
                        reject(new Error('复制失败，请手动选择链接复制'));
                    }
                });
            }

            function renderQrCode(container, text, size) {
                var correctLevel = window.QRCode.CorrectLevel;
                var levels = correctLevel
                    ? [correctLevel.H, correctLevel.Q, correctLevel.M, correctLevel.L]
                    : [2, 3, 0, 1];
                if (levels.some(function (level) {
                    return typeof level === 'undefined';
                })) {
                    levels = [2, 3, 0, 1];
                }

                for (var index = 0; index < levels.length; index += 1) {
                    container.innerHTML = '';
                    try {
                        new window.QRCode(container, {
                            width: size,
                            height: size,
                            text: text,
                            correctLevel: levels[index]
                        });
                        return true;
                    } catch (error) {
                        // 长链接可能超过当前纠错级别容量，继续尝试更低级别。
                    }
                }

                container.innerHTML = '';
                return false;
            }

            function showQr(data, nodeName) {
                var url = getNodeUrl(data);
                var protocol = data.protocol || protocolNames[parseInt(data.sort, 10)] || '节点';
                qrTitle.textContent = nodeName + ' · ' + protocol;
                qrCode.innerHTML = '';
                qrFallback.style.display = 'none';
                qrUrl.textContent = url;
                if (!url) {
                    qrFallback.textContent = '该节点暂时没有可用的节点链接';
                    qrFallback.style.display = '';
                } else if (window.QRCode) {
                    if (!renderQrCode(qrCode, url, 240)) {
                        qrFallback.textContent = '二维码生成失败，请使用“复制节点链接”导入';
                        qrFallback.style.display = '';
                    }
                } else {
                    qrFallback.textContent = '二维码组件加载失败，请使用“复制节点链接”导入';
                    qrFallback.style.display = '';
                }
                showModal(qrModal);
            }

            function importShadowrocket(data) {
                var url = getShadowrocketUrl(data);
                if (!url) {
                    showMessage('该协议暂不支持 Shadowrocket 导入', true);
                    return;
                }
                try {
                    window.location.href = 'shadowrocket://add/' + encodeURIComponent(url);
                } catch (error) {
                    showMessage('无法打开 Shadowrocket，请复制节点链接导入', true);
                }
            }

            function openConfig(nodeId, nodeName) {
                currentConfig = null;
                configTitle.textContent = nodeName + ' · 节点配置';
                configProtocol.textContent = '';
                configStatus.textContent = '';
                configUrl.value = '';
                configDetails.innerHTML = '';
                configShadowrocket.disabled = true;
                setConfigState(true, '');
                showModal(configModal);
                fetchConfig(nodeId).then(function (data) {
                    renderConfig(data, nodeName);
                }).catch(function (error) {
                    setConfigState(false, error.message || '无法获取节点配置');
                });
            }

            function runNodeAction(nodeId, nodeName, action) {
                fetchConfig(nodeId).then(function (data) {
                    if (action === 'copy') {
                        return copyText(getNodeUrl(data)).then(function () {
                            showMessage('节点链接已复制', false);
                        });
                    }
                    if (action === 'qr') {
                        showQr(data, nodeName);
                        return null;
                    }
                    importShadowrocket(data);
                    return null;
                }).catch(function (error) {
                    showMessage(error.message || '无法获取节点配置', true);
                });
            }

            configCopy.addEventListener('click', function () {
                if (!currentConfig) {
                    return;
                }
                copyText(getNodeUrl(currentConfig)).then(function () {
                    showMessage('节点链接已复制', false);
                }).catch(function (error) {
                    showMessage(error.message, true);
                });
            });
            configQr.addEventListener('click', function () {
                if (currentConfig) {
                    var nodeName = configTitle.textContent.replace(/ · 节点配置$/, '');
                    var config = currentConfig;
                    hideModal(configModal);
                    window.setTimeout(function () {
                        showQr(config, nodeName);
                    }, 180);
                }
            });
            configShadowrocket.addEventListener('click', function () {
                if (currentConfig) {
                    importShadowrocket(currentConfig);
                }
            });

            window.dedicatedNodeConfig = openConfig;
            window.dedicatedNodeCopy = function (nodeId) {
                runNodeAction(nodeId, '', 'copy');
            };
            window.dedicatedNodeQr = function (nodeId, nodeName) {
                runNodeAction(nodeId, nodeName, 'qr');
            };
            window.dedicatedNodeShadowrocket = function (nodeId, nodeName) {
                runNodeAction(nodeId, nodeName, 'shadowrocket');
            };
        }());

        (function () {
            var dedicatedPaymentNodeId = 0;
            var dedicatedPaymentPrice = 0;
            var dedicatedPaymentAction = 'buy';
            var modal = document.getElementById('dedicated-payment-modal');
            var dedicatedPaymentBalance = parseFloat(modal.getAttribute('data-user-balance')) || 0;
            var title = document.getElementById('dedicated-payment-title');
            var summary = document.getElementById('dedicated-payment-summary');
            var result = document.getElementById('dedicated-payment-result');
            var buttons = document.querySelectorAll('.dedicated-pay-option');
            var balanceButton = modal.querySelector('[data-type="balance"]');
            var pollTimer = null;
            var paymentWindow = null;
            var paymentWindowPending = false;

            var ownedModal = document.getElementById('dedicated-owned-modal');
            var renewConfirmModal = document.getElementById('dedicated-renew-confirm-modal');
            var renewConfirmNode = document.getElementById('dedicated-renew-confirm-node');
            var renewConfirmSubmit = document.getElementById('dedicated-renew-confirm-submit');
            var pendingRenewal = null;
            if (ownedModal && ownedModal.getAttribute('data-auto-open') === '1' && window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                window.jQuery(function () {
                    window.jQuery(ownedModal).modal('show');
                });
            }

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

            function resetPaymentButtons() {
                Array.prototype.forEach.call(buttons, function (button) {
                    button.disabled = false;
                    button.textContent = button.getAttribute('data-label');
                });
                if (!balanceButton) {
                    return;
                }
                if (dedicatedPaymentBalance + 0.001 < dedicatedPaymentPrice) {
                    balanceButton.disabled = true;
                    balanceButton.textContent = '余额不足（当前 ' + dedicatedPaymentBalance.toFixed(2) + ' 元）';
                    balanceButton.setAttribute('title', '请选择在线支付，现有余额会自动抵扣');
                    return;
                }
                balanceButton.removeAttribute('title');
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

            function showRenewConfirm(nodeId, nodeName, price) {
                if (!renewConfirmModal) {
                    openPayment('renew', nodeId, nodeName, price);
                    return;
                }
                pendingRenewal = {
                    nodeId: parseInt(nodeId, 10),
                    nodeName: nodeName,
                    price: price
                };
                renewConfirmNode.textContent = nodeName;
                renewConfirmSubmit.disabled = false;
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery(renewConfirmModal).modal('show');
                    return;
                }
                renewConfirmModal.style.display = 'block';
                renewConfirmModal.classList.add('show');
                renewConfirmModal.setAttribute('aria-hidden', 'false');
            }

            function hideRenewConfirm() {
                if (!renewConfirmModal) {
                    return;
                }
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery(renewConfirmModal).modal('hide');
                    return;
                }
                renewConfirmModal.style.display = 'none';
                renewConfirmModal.classList.remove('show');
                renewConfirmModal.setAttribute('aria-hidden', 'true');
            }

            function startRenewal(renewal) {
                if (ownedModal && window.jQuery && window.jQuery.fn && window.jQuery.fn.modal
                    && window.jQuery(ownedModal).hasClass('show')) {
                    window.jQuery(ownedModal).one('hidden.bs.modal', function () {
                        openPayment('renew', renewal.nodeId, renewal.nodeName, renewal.price);
                    });
                    window.jQuery(ownedModal).modal('hide');
                    return;
                }
                openPayment('renew', renewal.nodeId, renewal.nodeName, renewal.price);
            }

            function confirmRenewal() {
                var renewal = pendingRenewal;
                if (renewConfirmSubmit) {
                    renewConfirmSubmit.disabled = true;
                }
                pendingRenewal = null;
                if (!renewal) {
                    return;
                }
                if (renewConfirmModal && window.jQuery && window.jQuery.fn && window.jQuery.fn.modal
                    && window.jQuery(renewConfirmModal).hasClass('show')) {
                    window.jQuery(renewConfirmModal).one('hidden.bs.modal', function () {
                        startRenewal(renewal);
                    });
                    hideRenewConfirm();
                    return;
                }
                hideRenewConfirm();
                startRenewal(renewal);
            }

            function openPayment(action, nodeId, nodeName, price) {
                stopPolling();
                paymentWindow = null;
                paymentWindowPending = false;
                dedicatedPaymentAction = action;
                dedicatedPaymentNodeId = parseInt(nodeId, 10);
                dedicatedPaymentPrice = parseFloat(price);
                title.textContent = action === 'renew' ? '专用节点续费' : '选择支付方式';
                var balanceUsed = Math.min(Math.max(dedicatedPaymentBalance, 0), dedicatedPaymentPrice);
                var onlineAmount = Math.max(0, dedicatedPaymentPrice - balanceUsed);
                if (action === 'renew') {
                    summary.textContent = nodeName + '，续费 ' + dedicatedPaymentPrice.toFixed(2) + ' 元；本次将覆盖当前有效期和专用流量。余额抵扣 ' + balanceUsed.toFixed(2) + ' 元，在线支付 ' + onlineAmount.toFixed(2) + ' 元';
                } else {
                    summary.textContent = nodeName + '，总价 ' + dedicatedPaymentPrice.toFixed(2) + ' 元；余额抵扣 ' + balanceUsed.toFixed(2) + ' 元，在线支付 ' + onlineAmount.toFixed(2) + ' 元';
                }
                clearResult();
                resetPaymentButtons();
                showModal();
            }

            window.dedicatedBuy = function (nodeId, nodeName, price) {
                openPayment('buy', nodeId, nodeName, price);
            };

            window.dedicatedRenew = function (nodeId, nodeName, price) {
                showRenewConfirm(nodeId, nodeName, price);
            };

            if (renewConfirmSubmit) {
                renewConfirmSubmit.addEventListener('click', confirmRenewal);
            }
            if (renewConfirmModal) {
                Array.prototype.forEach.call(renewConfirmModal.querySelectorAll('[data-dismiss="modal"]'), function (button) {
                    button.addEventListener('click', function () {
                        pendingRenewal = null;
                    });
                });
                if (window.jQuery && window.jQuery.fn && window.jQuery.fn.modal) {
                    window.jQuery(renewConfirmModal).on('hidden.bs.modal', function () {
                        pendingRenewal = null;
                    });
                }
            }

            Array.prototype.forEach.call(modal.querySelectorAll('[data-dismiss="modal"]'), function (button) {
                button.addEventListener('click', hideModal);
            });

            Array.prototype.forEach.call(buttons, function (button) {
                button.setAttribute('data-label', button.textContent);
                button.addEventListener('click', function () {
                    var paymentType = button.getAttribute('data-type');
                    var body = new URLSearchParams();
                    var isBalancePayment = paymentType === 'balance';
                    var isRenewal = dedicatedPaymentAction === 'renew';
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
                        body.set('dedicated_node_renew', isRenewal ? '1' : '0');
                    }
                    button.disabled = true;
                    button.textContent = '正在创建订单...';
                    Array.prototype.forEach.call(buttons, function (item) {
                        item.disabled = true;
                    });

                    fetch(isBalancePayment
                        ? (isRenewal ? '/user/dedicated-node/renew' : '/user/dedicated-node/buy')
                        : '/user/payment/purchase', {
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
                            throw new Error((data && data.msg) || (isBalancePayment
                                ? (isRenewal ? '专用节点续费失败' : '余额支付失败')
                                : '创建支付订单失败'));
                        }
                        if (isBalancePayment) {
                            title.textContent = isRenewal ? '续费成功' : '购买成功';
                            setResult(data.msg || (isRenewal ? '余额支付成功，专用节点已续费' : '余额支付成功，专用节点已开通'), false, false);
                            button.textContent = isRenewal ? '已续费' : '已开通';
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
                        resetPaymentButtons();
                        if (!button.disabled) {
                            button.textContent = '重新支付';
                        }
                    });
                });
            });
        }());
    </script>
    {/literal}
</body>
</html>
