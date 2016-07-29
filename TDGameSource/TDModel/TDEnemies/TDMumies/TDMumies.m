//
//  TDMumies.m
//  Test
//
//  Created by dRumyankov on 7/29/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDMumies.h"

#define kNameSprite @"td_mumies_move"

const NSInteger speedMoveMumies = 45;
const NSInteger armorMumies = 1;
const NSInteger hitPointsMumies = 140;
const NSInteger rewardMumies = 15;

const NSInteger damageMumies = 1;

@implementation TDMumies


- (id)initWithRespawnPoint:(CGPoint)respawnPoint delegate:(id)delegate{
    if(self = [super init]){
        
        maxHitPoints_ = hitPoints_ = hitPointsMumies;
        armor_ = armorMumies;
        
        speed_ = speedMoveMumies;
        
        reward_ = rewardMumies;
        damage_ = damageMumies;
        
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
