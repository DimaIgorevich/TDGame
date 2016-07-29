//
//  TDNightmare.m
//  Test
//
//  Created by dRumyankov on 7/29/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDNightmare.h"


#define kNameSprite @"td_nightmare_move"

const NSInteger speedMoveNightmare = 38;
const NSInteger armorNightmare = 2;
const NSInteger hitPointsNightmare = 180;
const NSInteger rewardNightmare = 25;

const NSInteger damageNightmare = 1;


@implementation TDNightmare


- (id)initWithRespawnPoint:(CGPoint)respawnPoint delegate:(id)delegate{
    if(self = [super init]){
        
        maxHitPoints_ = hitPoints_ = hitPointsNightmare;
        armor_ = armorNightmare;
        
        speed_ = speedMoveNightmare;
        
        reward_ = rewardNightmare;
        damage_ = damageNightmare;
        
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
