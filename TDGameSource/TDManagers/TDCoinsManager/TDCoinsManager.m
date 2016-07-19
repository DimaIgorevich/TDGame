//
//  TDCoinsManager.m
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDCoinsManager.h"

@implementation TDCoinsManager

- (id)initWithCoins:(NSInteger)coins energy:(NSInteger)energy{
    if(self = [super init]){
        coins_ = coins;
        energy_ = energy;
    }
    return self;
}

- (void)buy:(NSInteger)cost energy:(NSInteger)energy{
    energy_ -= energy;
    coins_ -= cost;
}

- (void)profit:(NSInteger)profit{
    coins_ += profit;
}

- (void)update{
    [_delegate updateCoins:coins_];
    [_delegate updatePowerEnergy:energy_];
}

- (BOOL)canMakePurchaseBuild:(NSInteger)cost electricPower:(NSInteger)enegry{
    return coins_ >= cost && energy_ >= enegry;
}

- (BOOL)isLackOfEnergy:(NSInteger)enegry{
    return energy_ < enegry;
}

- (BOOL)isLackOfMoney:(NSInteger)cost{
    return coins_ < cost;
}

@end
