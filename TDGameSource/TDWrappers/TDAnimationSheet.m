//
//  TDAnimationSheet.m
//  TowerDefense
//
//  Created by dRumyankov on 4/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDAnimationSheet.h"

const CGFloat kDefaultDelay = 0.1f;
const CGFloat kDefaultDurationFadeOut = 0.12f;
const NSInteger kStartIndexName = 1;

//need POINT, HIDE(?) 

@implementation TDAnimationSheet

@synthesize actionSprite = actionSprite_;

- (id)initWithSpriteName:(NSString *)nameSource delegate:(id)delegate respawnPoint:(CGPoint)point{
    if(self = [super init]){
        source_ = nameSource;
        delegate_ = delegate;
        pointRespawn_ = point;
        countFrame_ = [self countFrame];
        _delay = kDefaultDelay;
        _durationFadeOut = kDefaultDurationFadeOut;
    }
    return self;
}

- (NSInteger)countFrame{
    NSString *bundlePlist = [[NSBundle mainBundle] pathForResource:source_ ofType:@"plist"];
    NSDictionary *rootDictionary = [NSDictionary dictionaryWithContentsOfFile:bundlePlist];
    NSDictionary *frameDictionary = [rootDictionary objectForKey:@"frames"];
    return [frameDictionary count];
}

- (void)addSpriteFramesToCatche{
    CCSpriteFrameCache *frameCathe = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCathe addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", source_]];
}

- (void)addChildToDelegate{
    spriteSheet_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png", source_]];
    
    [delegate_ addChild:spriteSheet_ z:2];
}

- (void)startAnimate{
    
    [self addSpriteFramesToCatche];
        
    [self addChildToDelegate];
    
    NSArray *frames = [self arrayWithFrames];
    
    actionSprite_ = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%@1.png", source_]];
    
    actionSprite_.position = pointRespawn_;
       
    NSMutableArray *arrayAction = [[NSMutableArray alloc] init];
    
    [self addActionOfAnimation:arrayAction withFrames:frames];
    
    if(_isHideAfterEndAnimation && !_isRepeatAnimation){
        [self hideAfterEndAnimation:arrayAction];
    }
    
    CCActionSequence *sequanceActions = [CCActionSequence actionWithArray:arrayAction];
    
    [actionSprite_ runAction:sequanceActions];
    [spriteSheet_ addChild:actionSprite_];
}

- (void)setSpriteMoveToPoint:(CGPoint)toPoint withDuration:(CGFloat)duration{
    [actionSprite_ runAction:[CCActionMoveTo actionWithDuration:duration position:toPoint]];
}

- (void)stopAnimate{
    [spriteSheet_ removeFromParent];
}

- (void)addActionOfAnimation:(NSMutableArray *) arrayActions withFrames:(NSArray *)frames{
    CCAnimation *runAnim = [CCAnimation animationWithSpriteFrames:frames delay:_delay];
    CCActionAnimate *action;
    if(_isRepeatAnimation){
        action = [CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:runAnim]];
    } else {
        action = [CCActionAnimate actionWithAnimation:runAnim];
    }
    
    [arrayActions addObject:action];
}

- (void)hideAfterEndAnimation:(NSMutableArray *) arrayActions{
    CCActionAnimate *fadeOut = [CCActionFadeOut actionWithDuration:_durationFadeOut];
    [arrayActions addObject:fadeOut];
    [self removeAfterHide:arrayActions];
}

- (void)removeAfterHide:(NSMutableArray *)arrayActions{
   // CCActionAnimate *remove = [CCActionRemove actionWithCleanUp:YES];
   // [arrayActions addObject:remove];
}

- (NSArray *)arrayWithFrames{
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    for(int i = kStartIndexName; i <= countFrame_; i++){
        [self addFrameTo:frames numberFrame:i];
    }
    if(_isAddReverceFrame){
        for(int i = (int)countFrame_; i >= kStartIndexName; i--){
            [self addFrameTo:frames numberFrame:i];
        }
    }
    return frames;
}

- (void)addFrameTo:(NSMutableArray *)frames numberFrame:(int)numberFrame{
    NSString  *filename = [NSString stringWithFormat:@"%@%d.png", source_, numberFrame];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:filename];
    [frames addObject:frame];
}

- (CGPoint)currentPositionActionSprite{
    return actionSprite_.position;
}

- (void)setNewRespawnPoint:(CGPoint)pointRespawn{
    pointRespawn_ = pointRespawn;
}

- (CGSize)sizeActionSprite{
    return actionSprite_.contentSize;
}

@end
