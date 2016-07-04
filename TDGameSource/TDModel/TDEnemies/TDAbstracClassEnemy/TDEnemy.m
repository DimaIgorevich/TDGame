//
//  TDEnemy.m
//  TowerDefense
//
//  Created by dRumyankov on 4/22/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDEnemy.h"
#import "MapScheme.h"
#import "TDProfitInfo.h"


#import "TDContainer.h"
#import "TDDamageProtocol.h"

const NSInteger kNormalDelta = 0;
const float kDefaultCoordinate = -100.0f;

@interface TDEnemy()<TDDamageProtocol>

@property (nonatomic) int currentPathObject;

@end

@implementation TDEnemy

@synthesize position = currentPosition_;

- (id)init{
    if(self = [super init]){
        isLife_ = YES;
        _currentPathObject = -1;
        
        CGPoint kDefaultPoint = CGPointMake(kDefaultCoordinate, kDefaultCoordinate);
        targetPoint_ = kDefaultPoint;
        currentPosition_ = kDefaultPoint;
        
        [self setDefaultMotionPreference];
    }
    return  self;
}

#pragma mark - Default Preference

- (void)setDefaultPreferenceSprities{
    [self defaultPreferenceForSprite:spriteWalkUp_];
    [self defaultPreferenceForSprite:spriteWalkDown_];
    [self defaultPreferenceForSprite:spriteWalkRight_];
    [self defaultPreferenceForSprite:spriteWalkLeft_];
}

- (void)setDefaultMotionPreference{
    
    movingDirection_ = kMovingNone;
    
    if(currentPosition_.x != kDefaultCoordinate){
        [self changeRespawnPoint];
    }
}

- (void)defaultPreferenceForSprite:(TDAnimationSheet *)sprite{
    sprite.isRepeatAnimation = YES;
    sprite.delay = 1.0f/speed_*10.0f;
}

#pragma mark - Stop Method Animation

- (void)stopSpritesMotion{
    [spriteWalkLeft_ stopAnimate];
    [spriteWalkRight_ stopAnimate];
    [spriteWalkDown_ stopAnimate];
    [spriteWalkUp_ stopAnimate];
}

#pragma mark - Walks Methods

- (void)setIndicatorLife{
    lifeIndicator_ = [[TDLifeIndicator alloc] initWithFullHitPoint:maxHitPoints_];
    [lifeIndicator_ correctiveLifeValue:hitPoints_];
    
    CGPoint indicatorPosition = CGPointMake(lifeIndicator_.position.x + [currentSpriteOnSubview_ sizeActionSprite].width/4, lifeIndicator_.position.y + [currentSpriteOnSubview_ sizeActionSprite].height);
    [lifeIndicator_ setPosition:indicatorPosition];
//
//
    [currentSpriteOnSubview_.actionSprite addChild:lifeIndicator_];
}

- (void)march{
    //find next point
    [self moveToPoint:[self findNextPoint]];
}

- (void)runWalk:(TDAnimationSheet *)spriteDirection{
    [self resetMotions];
    currentSpriteOnSubview_ = spriteDirection;
    
    [spriteDirection startAnimate];
    [spriteDirection setSpriteMoveToPoint:targetPoint_ withDuration:lengthWay_ / speed_];
    
    [self setIndicatorLife];
}

- (void)prepareWalkUp{
    [self runWalk:spriteWalkUp_];
    movingDirection_ = kMovingUp;
}

- (void)prepareWalkDown{
    [self runWalk:spriteWalkDown_];
    movingDirection_ = kMovingDown;
}

- (void)prepareWalkRight{
    [self runWalk:spriteWalkRight_];
    movingDirection_ = kMovingRigth;
}

- (void)prepareWalkLeft{
    [self runWalk:spriteWalkLeft_];
    movingDirection_ = kMovingLeft;
}

- (void)resetMotions{
    [self stopSpritesMotion];
    [self setDefaultMotionPreference];
}

#pragma mark - ItemPosition Methods

- (void)moveToPoint:(CGPoint)targetPoint{
    targetPoint_ = targetPoint;
    
    [self definitionNextStep];
}

- (void)definitionNextStep{
    
    CGPoint deltaPoint = [self deltaPoint];
    
    lengthWay_ = [self calculateLenthWay:deltaPoint];
    
    if([self isOutOfMap:deltaPoint]){
        [self achiveTargetPoint];
    } else {
        [self findDirectionToPoint:deltaPoint];
    }
    
}

- (void)findDirectionToPoint:(CGPoint)deltaPoint{
    if(deltaPoint.y > kNormalDelta){
        [self prepareWalkDown];
    }
    if(deltaPoint.y < kNormalDelta){
        [self prepareWalkUp];
    }
    if(deltaPoint.x > kNormalDelta){
        [self prepareWalkLeft];
    }
    if(deltaPoint.x < kNormalDelta){
        [self prepareWalkRight];
    }
}

- (CGPoint)deltaPoint{
    CGFloat dx = [self currentPosition].x - targetPoint_.x;
    CGFloat dy = [self currentPosition].y - targetPoint_.y;
    
    CGPoint deltaPoint = CGPointMake(dx, dy);
    
    return deltaPoint;
}

- (CGFloat)calculateLenthWay:(CGPoint)deltaPoint{
    return fabs(deltaPoint.x) + fabs(deltaPoint.y);
}

- (BOOL)isOutOfMap:(CGPoint)deltaPoint{
    return deltaPoint.x == kNormalDelta && deltaPoint.y == kNormalDelta;
}

- (CGPoint)currentPosition{
    if(movingDirection_ == kMovingUp){
        currentPosition_ = [spriteWalkUp_ currentPositionActionSprite];
    } else if(movingDirection_ == kMovingDown){
        currentPosition_ = [spriteWalkDown_ currentPositionActionSprite];
    } else if(movingDirection_ == kMovingLeft){
        currentPosition_ = [spriteWalkLeft_ currentPositionActionSprite];
    } else if(movingDirection_ == kMovingRigth){
        currentPosition_ = [spriteWalkRight_ currentPositionActionSprite];
    }
    return currentPosition_;
}

#pragma mark - RespawnPoint Method

- (void)changeRespawnPoint{
    [spriteWalkDown_ setNewRespawnPoint:currentPosition_];
    [spriteWalkUp_ setNewRespawnPoint:currentPosition_];
    [spriteWalkRight_ setNewRespawnPoint:currentPosition_];
    [spriteWalkLeft_ setNewRespawnPoint:currentPosition_];
}

- (CGSize)sizeSprite{
    CGSize sizeActor = CGSizeMake(48.0f, 48.0f);
    return sizeActor;
}

- (BOOL)isReachableTargetPoint {
    if(targetPoint_.x == [self currentPosition].x && targetPoint_.y == [self currentPosition].y){
        return YES;
    }
    return NO;
}


- (CGPoint)findNextPoint{
    
    if((int)[[TDContainer sharedContainer] pathObjects].count - 1 > _currentPathObject){
        _currentPathObject++;
    } else {
        CGPoint targetPoint = CGPointMake([[TDContainer sharedContainer] targetCell].x + [[TDContainer sharedContainer] mapLevel].tileSize.width/2, [[TDContainer sharedContainer] targetCell].y + [[TDContainer sharedContainer] mapLevel].tileSize.height/2);
        return targetPoint;
    }
    
    TDTiledMapCell *objectPath = [[[TDContainer sharedContainer] pathObjects] objectAtIndex:_currentPathObject];
    
    CGPoint nextPoint = CGPointMake(objectPath.x + [[TDContainer sharedContainer] mapLevel].tileSize.width/2, objectPath.y + [[TDContainer sharedContainer] mapLevel].tileSize.height/2);

    return nextPoint;
}

- (BOOL)isStayState{
    return movingDirection_ == kMovingNone;
}

- (CGPoint)indexPoint:(CGPoint)point{
    NSInteger indexX = point.x/[TDMapCell sizeMapCell].height;
    NSInteger indexY = point.y/[TDMapCell sizeMapCell].width;
    
    return CGPointMake(indexX, indexY);
}

- (void)checkTargetPoint{
    if([self isReachableTargetPoint]){
        [self moveToPoint:[self findNextPoint]];
    }
}

- (void)removeSelfFromDelegateScene{
    [self stopSpritesMotion];
    isLife_ = NO;
}

- (BOOL)isLife{
    return isLife_;
}

- (CCSprite *)sprite{
    return currentSpriteOnSubview_.actionSprite;
}

- (void)achiveTargetPoint{
    [_manager killWithOutReward:damage_];
    [self removeSelfFromDelegateScene];
}

- (void)kill{
    //NSLog(@"kill in position: %f - %f", [self position].x, [self position].y);
    
    TDProfitInfo *info = [[TDProfitInfo alloc] initWithProfit:reward_];
    [info addAnimation:delegate_ byPosition:self.position];
    
    [_manager reward:reward_];
    [self removeSelfFromDelegateScene];
}

#pragma  mark - TDDamageProtocol

- (void)damagedObject:(int)damage{
    hitPoints_ -= ((damage - armor_)>=0)?damage - armor_:0;
    [lifeIndicator_ correctiveLifeValue:hitPoints_];
    
    //NSLog(@"hitPoints: %d", (int)hitPoints_);
    if([self isLife]){
        if(hitPoints_ <= 0){
            [self kill];
        }
    }
}

//case corrective target point bullet: (two methods)
- (NSInteger)speedMotion{
    return speed_;
}

- (MovingDirection)currentDirection{
    return movingDirection_;
}

@end
