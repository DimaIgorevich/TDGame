//
//  TDLifeIndicator.m
//  TowerDefense
//
//  Created by dRumyankov on 5/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDLifeIndicator.h"
#import "CCSprite+SizeToFit.h"

const NSInteger kFullLife = 5;
const NSInteger kFullPercentLife = 100;

@implementation TDLifeIndicator

- (id)initWithFullHitPoint:(NSInteger)hitPoint{
    if(self = [super init]){
        CCNodeColor *fillColor = [CCNodeColor nodeWithColor:[CCColor colorWithUIColor:[UIColor redColor]]];
        CCNodeColor *hitPointsColor = [CCNodeColor nodeWithColor:[CCColor colorWithUIColor:[UIColor greenColor]]];
        
        [self addChild:fillColor];
        
        progress_ = [[CCSprite alloc] init];
        [progress_ setTextureRect:CGRectMake(0, 0, 100, 100)];
        [progress_ addChild:hitPointsColor];
        progress_.anchorPoint = CGPointZero;
        
        [self addChild:progress_];
        
        _fullHitPoint = hitPoint;
        
        [self setTextureRect:CGRectMake(0, 0, 100, 100)];
        [self sizeToCustomFit:CGSizeMake(kFullLife, 1)];
        [progress_ sizeToCustomFit:CGSizeMake(self.contentSize.width, self.contentSize.height)];
        self.anchorPoint = CGPointZero;
    }
    return self;
}

- (void)correctiveLifeValue:(NSInteger)value{
    //NSLog(@"corrective value %f", [self toRelativeValues:value]);
    CGFloat progressBarValue = [self toRelativeValues:value];
    
    [progress_ sizeToCustomFit:CGSizeMake(progressBarValue, self.contentSize.height)];
}

- (CGFloat)toRelativeValues:(NSInteger)value{
    CGFloat hitPointPercent = kFullPercentLife*value/_fullHitPoint;
    return hitPointPercent*self.contentSize.width/kFullPercentLife;
}

@end
