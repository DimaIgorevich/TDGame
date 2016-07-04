//
//  TDProfitAnimation.m
//  Test
//
//  Created by dRumyankov on 7/4/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDProfitInfo.h"

const CGFloat actionDuration = 0.8f;
const CGFloat deltaCoordinateY = 10;

@implementation TDProfitInfo

- (id)initWithProfit:(NSInteger)profit{
    if(self = [super init]){
        [self setFontName:@"Futura-CondensedExtraBold"];
        [self setFontSize:12.0f];
        [self setString:[NSString stringWithFormat:@"+%d", profit]];
        [self setColor:[CCColor colorWithUIColor:[UIColor blackColor]]];
    }
    
    return self;
}

- (void)addAnimation:(CCNode *)parent byPosition:(CGPoint)position{
    self.position = position;
    [parent addChild:self];
    
    [self startAnimation];
}

- (void)startAnimation{
    CCActionSequence *sequanceActions = [CCActionSequence actionWithArray:[self arrayWithActionAnimation]];
    
    [self runAction:sequanceActions];
}

- (CGPoint)deltaPositionByCoordinateY{
    return CGPointMake(self.position.x, self.position.y + deltaCoordinateY);
}

- (NSArray *)arrayWithActionAnimation{
    return [NSArray arrayWithObjects:[CCActionMoveTo actionWithDuration:actionDuration position:[self deltaPositionByCoordinateY]], [CCActionRemove action], nil];
}

@end
