//
//  TDBuildManager.m
//  TowerDefense
//
//  Created by dRumyankov on 5/23/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDBuildManager.h"

@implementation TDBuildManager

- (id)initWithDelegate:(id)delegate{
    if(self = [super init]){
        delegate_ = delegate;
    }
    return self;
}

- (void)showBuildMenu:(CGPoint)showPoint{
    buildMenu_ = [[TDBuildMenu alloc] initWithManager:self];
    buildMenu_.delegate = delegate_;
    showPoint_ = showPoint;
    CGPoint adaptivePoint = [TDBuildMenu showFrame:showPoint].origin;
    buildMenu_.positionType = CCPositionTypeUIPoints;
    buildMenu_.position = CGPointMake(adaptivePoint.x, adaptivePoint.y);
    [buildMenu_ show];
}

- (void)hideBuildMenu{
    [buildMenu_ hide];
    buildMenu_ = nil;
}

- (BOOL)isShowBuildMenu{
    return buildMenu_ != nil;
}

- (CGPoint)menuPosition{
    return showPoint_;
}

#pragma mark - TDCloseProtocol

- (void)dismiss{
    [self hideBuildMenu];
}

@end
