<?php


namespace App\Utils;

use App\Models\User;

class Check
{
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

    public static function findEmailOwner($email, $ignoreUserId = null)
    {
        $email = strtolower(trim($email));
        $user = User::where('email', '=', $email)->first();
        if ($user != null && (string) $user->id !== (string) $ignoreUserId) {
            return $user;
        }

        $normalizedEmail = self::normalizeEmail($email);
        $email_exp = explode('@', $normalizedEmail, 2);
        if (count($email_exp) !== 2 || $email_exp[1] !== 'gmail.com') {
            return null;
        }

        $gmailUsers = User::where('email', 'LIKE', '%@gmail.com')->orWhere('email', 'LIKE', '%@googlemail.com')->get();
        foreach ($gmailUsers as $gmailUser) {
            if (
                (string) $gmailUser->id !== (string) $ignoreUserId &&
                self::normalizeEmail($gmailUser->email) === $normalizedEmail
            ) {
                return $gmailUser;
            }
        }

        return null;
    }

    // 兼容旧调用名
    public static function isGmailSmall($email)
    {
        return self::isEmailAliasLegal($email);
    }
}
