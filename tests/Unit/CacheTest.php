<?php

namespace Tests\Unit;

use Illuminate\Support\Facades\Cache;
use Tests\TestCase;

class CacheTest extends TestCase
{
    public function test_a_cache_can_be_set()
    {
        Cache::put('food', 'pizza');
        $this->assertSame('pizza', cache('food'));
    }
}
