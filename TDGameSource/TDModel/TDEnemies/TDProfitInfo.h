//
//  TDProfitAnimation.h
//  Test
//
//  Created by dRumyankov on 7/4/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <CCLabelTTF.h>

@interface TDProfitInfo : CCLabelTTF

- (id)initWithProfit:(NSInteger)profit;
- (void)addAnimation:(CCNode *)parent byPosition:(CGPoint)position;

@end
