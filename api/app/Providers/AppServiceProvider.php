<?php

namespace App\Providers;

use App\Repositories\RepositoryInterface;
use App\Repository\EloquentRepository;
use Illuminate\Support\ServiceProvider;
use Laravel\Sanctum\Sanctum;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register()
    {
        Sanctum::ignoreMigrations();
        $this->app->bind(RepositoryInterface::class, EloquentRepository::class);
    }
    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
