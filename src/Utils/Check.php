<?php


namespace App\Utils;

use App\Models\User;

class Check
{
    private static function ignoreUserId($query, $ignoreUserId)
    {
        if ($ignoreUserId !== null && $ignoreUserId !== '') {
            $query->where('id', '!=', $ignoreUserId);
        }

        return $query;
    }

    //
    public static function isEmailLegal($email)
    {
        return filter_var($email, FILTER_VALIDATE_EMAIL) && strlen($email) <= 32;
    }

    public static function normalizeEmail($email)
    {
        $email = strtolower(trim($email));
        $email_exp = explode('@', $email, 2);
        if (count($email_exp) !== 2) {
            return $email;
        }

        $local = $email_exp[0];
        $domain = $email_exp[1];

        if ($domain === 'googlemail.com') {
            $domain = 'gmail.com';
        }

        if ($domain === 'gmail.com') {
            $local = explode('+', $local, 2)[0];
            $local = str_replace('.', '', $local);
        }

        return $local . '@' . $domain;
    }

    // 禁止邮箱别名小号注册，例如 name+tag@example.com
    public static function isEmailAliasLegal($email)
    {
        $email_exp = explode('@', strtolower(trim($email)), 2);
        if (count($email_exp) !== 2) {
            return false;
        }

        return strpos($email_exp[0], '+') === false;
    }

    private static function findNormalizedGmailOwner($normalizedEmail, $ignoreUserId = null)
    {
        return self::ignoreUserId(
            User::whereRaw("LOWER(SUBSTRING_INDEX(TRIM(email), '@', -1)) IN ('gmail.com', 'googlemail.com')")
                ->whereRaw(
                    "CONCAT(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(LOWER(TRIM(email)), '@', 1), '+', 1), '.', ''), '@gmail.com') = ?",
                    [$normalizedEmail]
                ),
            $ignoreUserId
        )->first();
    }

    public static function findEmailOwner($email, $ignoreUserId = null)
    {
        $email = strtolower(trim($email));
        $user = self::ignoreUserId(
            User::whereRaw('LOWER(TRIM(email)) = ?', [$email]),
            $ignoreUserId
        )->first();
        if ($user != null) {
            return $user;
        }

        $normalizedEmail = self::normalizeEmail($email);
        $email_exp = explode('@', $normalizedEmail, 2);
        if (count($email_exp) !== 2 || $email_exp[1] !== 'gmail.com') {
            return null;
        }

        return self::findNormalizedGmailOwner($normalizedEmail, $ignoreUserId);
    }

    // 兼容旧调用名
    public static function isGmailSmall($email)
    {
        $email = strtolower(trim($email));
        if (!self::isEmailAliasLegal($email)) {
            return false;
        }

        $normalizedEmail = self::normalizeEmail($email);
        $email_exp = explode('@', $normalizedEmail, 2);
        if (count($email_exp) !== 2 || $email_exp[1] !== 'gmail.com') {
            return true;
        }

        $user = self::findNormalizedGmailOwner($normalizedEmail);
        if ($user == null) {
            return true;
        }

        return strtolower(trim($user->email)) === $email;
    }
}
