<?php

namespace App\Services;

class Auth
{

    protected $user;

    private static function getDriver()
    {
        return Factory::createAuth();
    }

    public static function login($uid, $time)
    {
        self::getDriver()->login($uid, $time);
    }

    public static function resolveLoginDuration($rememberMe)
    {
        $defaultHours = (int) ($_ENV['loginDuration24Hours'] ?? 24);
        $rememberDays = (int) ($_ENV['rememberMeDuration'] ?? 7);

        if ($rememberMe === null || $rememberMe === '' || $rememberMe === false) {
            return 3600 * $defaultHours;
        }

        $value = is_string($rememberMe)
            ? strtolower(trim($rememberMe))
            : $rememberMe;

        if ($value === true || $value === 1 || $value === '1' || $value === 'true' || $value === 'on' || $value === 'week') {
            return 3600 * 24 * $rememberDays;
        }

        switch ($value) {
            case '24h':
                return 3600 * $defaultHours;
            case '7d':
                return 3600 * 24 * $rememberDays;
            default:
                return 3600 * 24 * $rememberDays;
        }
    }

    /**
     * Get current user(cached)
     *
     * @return \App\Models\User
     */
    public static function getUser()
    {
        global $user;
        if ($user === null) {
            $user = self::getDriver()->getUser();
        }
        return $user;
    }

    public static function logout()
    {
        self::getDriver()->logout();
    }
}
