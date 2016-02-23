# auctioneer
[![Build Status](https://travis-ci.org/MrCherry/auctioneer.svg?branch=master)](https://travis-ci.org/MrCherry/auctioneer)

## The task

As an input you have several entities, so called "creatives". Each of them has: 
* price 
* id of advertiser 
* country name to serve (optional)

Please implement a function auction, receiving:
* array of creatives
* number of winners
* country name (optional)

Function should return winner creatives, obeying the following rules:
1. All winners must have unique advertiser id
2. If third argument (country) is provided, then only creatives without country or creatives with same country can be among winners
3. Function should not give preference to any of equal by price creatives, but should return such creatives equiprobable.

Please cover your solution with tests.

Consider a case with several input creatives equal by price and several function calls with same input, output results may be different.

## Installation

#### Clone project's repository
```
git clone git@github.com:MrCherry/auctioneer.git
cd auctioneer
```

#### Install bundler gem and project's dependencies
```
gem install bundler
bundle install
```

## Usage

#### Select 5 creatives without country filtering
```
bin/auction more_creatives.json 5
```

#### Select 2 creatives from UK
```
bin/auction creatives.json 2 UK
```

#### Select 1 creative from USA
```
bin/auction another_creatives.json 1 USA
```

## Tests

#### Command
```
bundle exec rake
```

