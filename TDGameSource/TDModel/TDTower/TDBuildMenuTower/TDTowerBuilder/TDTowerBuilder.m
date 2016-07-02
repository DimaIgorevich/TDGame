//
//  TDTowerBuilder.m
//  TowerDefense
//
//  Created by dRumyankov on 5/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTowerBuilder.h"
#import "TDBuildProcessIndicator.h"
#import "CCSprite+SizeToFit.h"
#import "TDContainer.h"

NSString *kFoundationSkin = @"td_tower_base.png";
NSString *kProcessingSkin = @"td_tower_in_progress.png";

const CGFloat kTimeForBuild = 0.3f;
const CGFloat kOffsetIndicator = 20.0f;

@interface TDTowerBuilder()

@property (nonatomic) TDBuildProcessIndicator *processIndicator;

@end

@implementation TDTowerBuilder

- (CGFloat)run{
    [self buildFoundation];
    
    CGPoint buildPoint = _buildPosition;
    buildPoint.x -= kOffsetIndicator/2;
    buildPoint.y += kOffsetIndicator;
    
    _processIndicator = [[TDBuildProcessIndicator alloc] initWithPoint:buildPoint];
    [_delegate addChild:_processIndicator.indicatorProcess z:3];
    
    return 2*kTimeForBuild;
}

- (void)buildFoundation{
    buildSprite_ = [CCSprite spriteWithImageNamed: kFoundationSkin];
    [buildSprite_ sizeToCustomFit:[[TDContainer sharedContainer] mapLevel].tileSize];
    
    buildSprite_.anchorPoint = CGPointZero;
    buildSprite_.position = _buildPosition;
    
    [_delegate addChild:buildSprite_];
        
    [NSTimer scheduledTimerWithTimeInterval:kTimeForBuild target:self selector:@selector(buildInProcess) userInfo:nil repeats:NO];
}

- (void)buildInProcess{
    
    [buildSprite_ removeFromParent];
    //[buildSprite_ cleanup];
    
    buildSprite_ = [CCSprite spriteWithImageNamed: kProcessingSkin];
    [buildSprite_ sizeToCustomFit:[[TDContainer sharedContainer] mapLevel].tileSize];
    
    
    buildSprite_.anchorPoint = CGPointZero;
    buildSprite_.position = _buildPosition;
    
    [_delegate addChild:buildSprite_];

    
    [NSTimer scheduledTimerWithTimeInterval:kTimeForBuild target:self selector:@selector(finishBuild) userInfo:nil repeats:NO];
}

- (void)finishBuild{
    [buildSprite_ removeFromParent];
    //[buildSprite_ cleanup];
    
    [_processIndicator finishBuild];
}

@end
