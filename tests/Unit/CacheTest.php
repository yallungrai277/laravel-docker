<?php

namespace Tests\Unit;

use Tests\TestCase;
use Illuminate\Support\Facades\Cache;

class CacheTest extends TestCase
{
    public function test_a_cache_can_be_set()
    {
        Cache::put('food', 'pizza');
        $this->assertSame('pizza', cache('food'));
    }
}