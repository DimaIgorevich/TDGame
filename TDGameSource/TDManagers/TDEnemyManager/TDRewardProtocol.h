//
//  TDRewardProtocol.h
//  Test
//
//  Created by dRumyankov on 7/1/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDRewardProtocol <NSObject>

@required
- (void)reward:(NSInteger)rewardValue;
- (void)killWithOutReward:(NSInteger)damageValue;

@end
