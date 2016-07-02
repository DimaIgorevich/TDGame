//
//  TDSlayer.m
//  TowerDefense
//
//  Created by dRumyankov on 4/22/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDSlayer.h"

#define kNameSprite @"td_slayer_move"

const NSInteger speedMoveSlayer = 50;
const NSInteger armorSlayer = 2;
const NSInteger hitPointsSlayer = 100;
const NSInteger rewardSlayer = 12;
const NSInteger damageSlayer = 1;

@implementation TDSlayer

- (id)initWithRespawnPoint:(CGPoint)respawnPoint delegate:(id)delegate{
    if(self = [super init]){
        
        maxHitPoints_ = hitPoints_ = hitPointsSlayer;
        armor_ = armorSlayer;
        
        speed_ = speedMoveSlayer;
        
        reward_ = rewardSlayer;
        damage_ = damageSlayer;
        
        delegate_ = delegate;
        spriteWalkUp_ = [[TDAnimationSheet alloc] initWithSpriteName:[NSString stringWithFormat:@"%@%@", kNameSprite, kUpSuffix] delegate:delegate respawnPoint:respawnPoint];
        spriteWalkDown_ = [[TDAnimationSheet alloc] initWithSpriteName:[NSString stringWithFormat:@"%@%@", kNameSprite, kDownSuffix] delegate:delegate respawnPoint:respawnPoint];
        spriteWalkLeft_ = [[TDAnimationSheet alloc] initWithSpriteName:[NSString stringWithFormat:@"%@%@", kNameSprite, kLeftSuffix] delegate:delegate respawnPoint:respawnPoint];
        spriteWalkRight_ = [[TDAnimationSheet alloc] initWithSpriteName:[NSString stringWithFormat:@"%@%@", kNameSprite, kRigthSuffix] delegate:delegate respawnPoint:respawnPoint];
        
        currentPosition_ = respawnPoint;
        
        [self setDefaultPreferenceSprities];

    }
    return  self;
}

@end
