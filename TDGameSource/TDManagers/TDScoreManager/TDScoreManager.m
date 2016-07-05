//
//  TDScoreManager.m
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDScoreManager.h"

@implementation TDScoreManager

- (id)initWithHealth:(NSInteger)health{
    if(self = [super init]){
        health_ = health;
    }
    
    return self;
}

- (void)update{
    [_delegate updateScore:health_];
}

- (void)catchDamage:(NSInteger)damageValue{
    health_-= damageValue;
}

- (NSInteger)valueHealth{
    return health_;
}

- (BOOL)isHealthOver{
    return health_ <= 0;
}

@end
