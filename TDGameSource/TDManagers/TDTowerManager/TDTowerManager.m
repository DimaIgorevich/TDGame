//
//  TDTowerManager.m
//  TowerDefense
//
//  Created by dRumyankov on 5/23/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTowerManager.h"
#import "CCNode+CoordHelpers.h"

@implementation TDTowerManager

@synthesize towers = towers_;

- (id)init{
    if(self = [super init]){
        towers_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)scan:(TDEnemyWaveManager *)enemyManager{
    if(![self isEmptyTowers]){
        if(enemyManager.enemies != nil){
            for(TDTower *objectTower in towers_){
                for(TDEnemy *objectEnemy in enemyManager.enemies){
                    if([self isEnemy:objectEnemy inFieldOfVision:objectTower] && [objectEnemy isLife
                                                                                  ]){
                        if(objectTower.isReadyToFire){
                            TDBullet *bullet = [[TDBullet alloc] initWithCharacteristicBullet:[objectTower fire] spawner:objectTower target:objectEnemy];
                            [bullet draw];
                        } 
                    }
                }
            }
        }
    }
}

- (void)addTower:(TDTower *)tower{
    [towers_ addObject:tower];
    
    NSLog(@"Add tower %@", tower);
}

- (BOOL)isEmptyTowers{
    return towers_.count == 0;
}

- (BOOL)isEnemy:(TDEnemy *)enemy inFieldOfVision:(TDTower *)tower{
    if(tower.damageRadius == nil){
        return NO;
    }
    return !CGRectIsNull(CGRectIntersection([[enemy sprite] worldBoundingBox], [tower.damageRadius worldBoundingBox]));
}

@end
