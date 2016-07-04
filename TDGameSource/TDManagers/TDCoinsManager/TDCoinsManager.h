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
}

@property (nonatomic) id<TDCoinsProtocol> delegate;

- (id)initWithCoins:(NSInteger)coins;

- (void)buy:(NSInteger)cost;
- (void)profit:(NSInteger)profit;
- (void)update;

- (BOOL)canMakePurchaseBuild:(NSInteger)cost;

@end
