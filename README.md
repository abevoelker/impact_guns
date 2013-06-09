impact_guns
=============

Basic API for accessing http://www.impactguns.com/

## Examples

```ruby
require 'impact_guns'
rate_limit = Celluloid::RateLimiter.new(10, 1)
Celluloid::Actor[:session_pool] = ImpactGuns::Session.pool(args: [rate_limit])

nugget = ImpactGuns::Product.find('product.aspx?zpid=33537')
```
