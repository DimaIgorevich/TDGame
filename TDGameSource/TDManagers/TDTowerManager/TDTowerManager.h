//
//  TDTowerManager.h
//  TowerDefense
//
//  Created by dRumyankov on 5/23/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDEnemyWaveManager.h"
#import "TDTower.h"
#import "TDTowerArcher.h"
#import "TDTowerCannon.h"
#import "TDBullet.h"

@interface TDTowerManager : NSObject{
    NSMutableArray <TDTower *>*towers_;
}

@property (nonatomic) NSMutableArray <TDTower *>*towers;

- (void)scan:(TDEnemyWaveManager *)enemyManager;

- (void)addTower:(TDTower *)tower;

@end
