//
//  EnemyWaveController.h
//  TowerDefense
//
//  Created by dRumyankov on 4/26/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDEnemy.h"
#import "TDSlayer.h"
#import "TDMinotaur.h"
#import "TDMumies.h"
#import "TDNightmare.h"

#import "TDCoinsManager.h"
#import "TDScoreManager.h"
#import "TDWaveTimerManager.h"

#import "TDWaveProtocol.h"

typedef enum {
    kSlayerLvl,
    kMinotaurLvl,
    kMumiesLvl,
    kNigthmareLvl
} LvlType;

@interface TDEnemyWaveManager : NSObject {
    id mapDelegate_;
    
    NSInteger numberLvl_;
    NSInteger countEnemyCurrentWave_;
    
    NSMutableArray <TDEnemy *> *enemies_;
    
    NSTimer *timerRespawn_;
    
    CGFloat waveInterval_;
    
    NSInteger numEnemyStart_;
    NSInteger startChild_;
}

@property NSMutableArray <TDEnemy *> *enemies;
@property (nonatomic) NSInteger numberLvl;
@property (nonatomic) NSInteger countWaves;

@property (nonatomic) TDCoinsManager *coinsManager;
@property (nonatomic) TDScoreManager *scoreManager;
@property (nonatomic) TDWaveTimerManager* timerManager;
@property (nonatomic) id<TDWaveProtocol> delegate;

@property NSTimer *timerRespawn;

- (id)initWithMapDelegate:(id)mapDelegate;

- (void)render;

- (void)pause;
- (void)resume;
@end
