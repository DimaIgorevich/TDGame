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
        
        damage_ = 45;
        cost_ = costTowerArcher;
        speedBullet_ = 40;
        coolDown_ = 1.9f;
        radius_ = 35.0f;
    }
    return self;
}

@end
