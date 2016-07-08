//
//  TDTower.h
//  TowerDefense
//
//  Created by dRumyankov on 5/17/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDItemTower.h"
#import "CCSprite+SizeToFit.h"
#import "TDBulletCharacterStruct.h"
#import "TDTowersCost.h"

#import "TDTowerJSON.h"

@interface TDTower : NSObject{
    //main characteristic:
    CGFloat radius_;
    NSUInteger damage_;
    CGFloat speedBullet_;
    CGFloat coolDown_;
    NSInteger cost_;
    TypeItem typeTower_;
    NSInteger upgradeLevel_;
    
    //delegate:
    CCScene *delegate_;
    
    //skin tower
    CCSprite *towerSprite_;
    CCSprite *radiusSprite_;
    
    //build point:
    CGPoint position_;
    

}

@property (nonatomic) CCScene *delegate;
@property (nonatomic) CCSprite *damageRadius;
@property (nonatomic) BOOL isReadyToFire;
@property (nonatomic) CGPoint position;

- (id)initWithPoint:(CGPoint)buildPoint;
- (id)initWithJSONObject:(TDTowerJSON *)tower inPoint:(CGPoint)buildPoint;

- (void)buildTower;

- (NSInteger)valueCost;
- (TypeItem)typeTower;
- (NSInteger)upgradeLevel;

- (void)upgradeTower:(TDTowerJSON *)tower;

- (TDBulletCharacter)fire;

@end
