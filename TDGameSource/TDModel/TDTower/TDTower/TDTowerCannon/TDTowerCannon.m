//
//  TDTowerCannon.m
//  TowerDefense
//
//  Created by dRumyankov on 5/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTowerCannon.h"

@implementation TDTowerCannon

- (id)initWithPoint:(CGPoint)buildPoint{
    if(self = [super initWithPoint:buildPoint]){
        towerSprite_ = [CCSprite spriteWithImageNamed: @"td_tower_cannon.png"];
        
        upgradeLevel_ = 1;
        typeTower_ = kCannonTower;
        damage_ = 15;
        cost_ = costTowerCannon;
        speedBullet_ = 70;
        coolDown_ = 1.5f;
        radius_ = 35.0f;
    }
    return self;
}

@end
