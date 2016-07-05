//
//  TDScoreManager.h
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDScoreProtocol.h"

@interface TDScoreManager : NSObject{
    NSInteger health_;
}

@property (nonatomic) id<TDScoreProtocol> delegate;

- (id)initWithHealth:(NSInteger)health;

- (void)update;

- (void)catchDamage:(NSInteger)damageValue;
- (NSInteger)valueHealth;

- (BOOL)isHealthOver;

@end
