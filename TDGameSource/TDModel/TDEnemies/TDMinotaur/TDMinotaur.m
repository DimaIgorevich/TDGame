//
//  TDMinotaur.m
//  TowerDefense
//
//  Created by dRumyankov on 4/25/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDMinotaur.h"

#define kNameSprite @"td_minotaur_move"

const NSInteger speedMoveMinotaur = 40;
const NSInteger armorMinotaur = 2;
const NSInteger hitPointsMinotaur = 160;
const NSInteger rewardMinotaur = 18;
const NSInteger damageMinotaur = 1;

@implementation TDMinotaur

- (id)initWithRespawnPoint:(CGPoint)respawnPoint delegate:(id)delegate{
    if(self = [super init]){
        
        maxHitPoints_ = hitPoints_ = hitPointsMinotaur;
        armor_ = armorMinotaur;
        
        speed_ = speedMoveMinotaur;
        
        reward_ = rewardMinotaur;
        damage_ = damageMinotaur;
        
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
