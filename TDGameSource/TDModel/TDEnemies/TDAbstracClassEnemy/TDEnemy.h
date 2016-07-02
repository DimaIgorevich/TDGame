//
//  TDEnemy.h
//  TowerDefense
//
//  Created by dRumyankov on 4/22/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDAnimationSheet.h"
#import "TDLifeIndicator.h"

#import "TDRewardProtocol.h"

#define kUpSuffix @"_up"
#define kDownSuffix @"_down"
#define kLeftSuffix @"_left"
#define kRigthSuffix @"_right"

#define kDefaultMoveDelay 0.2f;

typedef enum {
    kMovingNone,
    kMovingUp,
    kMovingDown,
    kMovingLeft,
    kMovingRigth
} MovingDirection;

@interface TDEnemy : NSObject{
    CCScene *delegate_;
    
    BOOL isLife_;
    
    NSInteger maxHitPoints_;
    
    //main fields:
    NSInteger hitPoints_;
    NSInteger armor_;
    NSInteger speed_;
    
    //kills results:
    NSInteger reward_;
    NSInteger damage_;
    
    //lifeIndicator
    TDLifeIndicator *lifeIndicator_;
    
    //animationSprite (8)/4:
    TDAnimationSheet *spriteWalkUp_;
    TDAnimationSheet *spriteWalkDown_;
    TDAnimationSheet *spriteWalkRight_;
    TDAnimationSheet *spriteWalkLeft_;
    //
    TDAnimationSheet *currentSpriteOnSubview_;
    
    MovingDirection movingDirection_;
    
    // points:
    CGPoint currentPosition_;
    CGPoint targetPoint_;
    
    CGFloat lengthWay_;
}

@property (nonatomic) CGPoint position;
@property (nonatomic) id<TDRewardProtocol> manager;

- (void)march;

- (BOOL)isLife;

- (void)setDefaultPreferenceSprities;

//test:
- (CCSprite *)sprite;

//- (CGPoint)currentPosition; (?)deprecated

//case corrective target point bullet: (two methods)
- (NSInteger)speedMotion;
- (MovingDirection)currentDirection;


- (void)checkTargetPoint;

@end
