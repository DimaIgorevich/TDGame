//
//  TDTowerArcher.m
//  TowerDefense
//
//  Created by dRumyankov on 5/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTowerArcher.h"

@implementation TDTowerArcher

- (id)initWithPoint:(CGPoint)buildPoint{
    if(self = [super initWithPoint:buildPoint]){
        towerSprite_ = [CCSprite spriteWithImageNamed: @"td_tower_archers.png"];
        
        upgradeLevel_ = 1;
        typeTower_ = kArcherTower;
        damage_ = 26;
        cost_ = costTowerArcher;
        speedBullet_ = 60;
        coolDown_ = 1.63f;
        radius_ = 35.0f;
    }
    return self;
}

@end
