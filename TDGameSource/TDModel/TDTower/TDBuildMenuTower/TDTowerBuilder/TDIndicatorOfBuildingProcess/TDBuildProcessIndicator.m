//
//  TDBuildProcessIndicator.m
//  TowerDefense
//
//  Created by dRumyankov on 5/17/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDBuildProcessIndicator.h"

@implementation TDBuildProcessIndicator

@synthesize indicatorProcess = skinIndicator_;

- (id)initWithPoint:(CGPoint)position{
    if(self = [super init]){
        
        skinIndicator_ = [CCSprite spriteWithImageNamed:@"td_hammer_1.png"];
        skinIndicator_.anchorPoint = CGPointZero;
        skinIndicator_.position = position;
    
        intervalBetweenRotation_ = [NSTimer scheduledTimerWithTimeInterval:0.04f target:self selector:@selector(rotateIdentifier) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)rotateIdentifier{
    if(skinIndicator_.rotation < 40){
        skinIndicator_.rotation += 5.0f;
    } else {
        skinIndicator_.rotation = 0.0f;
    }
}

- (void)finishBuild{
    [skinIndicator_ removeFromParent];
    skinIndicator_ = nil;
    [intervalBetweenRotation_ invalidate];
    intervalBetweenRotation_ = nil;
}

@end
