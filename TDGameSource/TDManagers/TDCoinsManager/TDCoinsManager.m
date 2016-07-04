//
//  TDCoinsManager.m
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDCoinsManager.h"

@implementation TDCoinsManager

- (id)initWithCoins:(NSInteger)coins{
    if(self = [super init]){
        coins_ = coins;
    }
    return self;
}

- (void)buy:(NSInteger)cost{
    coins_ -= cost;
}

- (void)profit:(NSInteger)profit{
    coins_ += profit;
}

- (void)update{
    [_delegate updateCoins:coins_];
}

- (BOOL)canMakePurchaseBuild:(NSInteger)cost{
    return coins_ >= cost;
}

@end
