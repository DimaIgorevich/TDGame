//
//  TDAnimationSheet.h
//  TowerDefense
//
//  Created by dRumyankov on 4/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCScene.h"

@interface TDAnimationSheet : CCScene{
    CCScene *delegate_;
    CCSprite *actionSprite_;
    CCSpriteBatchNode *spriteSheet_;
    CGPoint pointRespawn_;
    NSString *source_;
    NSInteger countFrame_;
}

//upadate:
@property CCSprite *actionSprite;
//

@property CGFloat delay;
@property CGFloat durationFadeOut;

@property BOOL isHideAfterEndAnimation;
@property BOOL isRepeatAnimation;
@property BOOL isAddReverceFrame;

- (id)initWithSpriteName:(NSString *)nameSource delegate:(id)delegate respawnPoint:(CGPoint)point;

- (void)startAnimate;

- (void)setSpriteMoveToPoint:(CGPoint)toPoint withDuration:(CGFloat)duration;

- (void)stopAnimate;

- (CGPoint)currentPositionActionSprite;

- (void)setNewRespawnPoint:(CGPoint)pointRespawn;

- (CGSize)sizeActionSprite;

@end
