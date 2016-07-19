//
//  TDCoinsManager.h
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDCoinsProtocol.h"

@interface TDCoinsManager : NSObject{
    NSInteger coins_;
    NSInteger energy_;
}

@property (nonatomic) id<TDCoinsProtocol> delegate;

- (id)initWithCoins:(NSInteger)coins energy:(NSInteger)energy;

- (void)buy:(NSInteger)cost energy:(NSInteger)energy;
- (void)profit:(NSInteger)profit;
- (void)update;

- (BOOL)isLackOfEnergy:(NSInteger)enegry;
- (BOOL)isLackOfMoney:(NSInteger)cost;

- (BOOL)canMakePurchaseBuild:(NSInteger)cost electricPower:(NSInteger)enegry;

@end
