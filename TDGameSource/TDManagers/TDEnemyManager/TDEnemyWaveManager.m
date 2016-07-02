//
//  EnemyWaveController.m
//  TowerDefense
//
//  Created by dRumyankov on 4/26/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDEnemyWaveManager.h"
#import "TDContainer.h"

#import "TDRewardProtocol.h"

const NSInteger kStartLevelWave = 0;
const NSInteger kCountLevelWave = 2;

const NSInteger kStartCountEnemy = 10;

const NSInteger kNumberLastObjectEnemy = 0;

const CGFloat kStartInterval = 0.0f;

const CGFloat kTimeIntervalRespawnEnemy = 1.2f;
const CGFloat kTimeIncrementIntervalBeetwenWave = 6.0f;

@interface TDEnemyWaveManager() <TDRewardProtocol>

@property (nonatomic) NSDate *pauseStart;
@property (nonatomic) NSDate *previousFireDate;

@end

@implementation TDEnemyWaveManager

@synthesize enemies = enemies_;
@synthesize timerRespawn = timerRespawn_;
@synthesize numberLvl = numberLvl_;

- (id)initWithMapDelegate:(id)mapDelegate{
    if(self = [super init]){
        mapDelegate_ = mapDelegate;
        numberLvl_ = kStartLevelWave;
        _countWaves = kCountLevelWave;
                
        waveInterval_ = kStartInterval;
        
        countEnemyCurrentWave_ = kStartCountEnemy;
        
        startChild_ = [(CCScene *)mapDelegate_ children].count;///// WARNING! May be collision in future
        
        [self createNextWaveTimer];
    }
    return self;
}

#pragma mark - Methods EnemyWaveController

- (void)render{
    [self updateWave];
    
    if([self isNextWaveNeeded]){
        if([self isNextWaveAvalible]){
            [self createNextWave];
        }
    }
}

- (void)updateWave{
    if(![self isEmptyArrayWithEnemies]){
        for(TDEnemy *objectEnemy in enemies_){
            if([objectEnemy isLife]){
                [objectEnemy checkTargetPoint];
            }             
        }
    }
    
//    if((numberLvl_ == kCountLevelWave -1) && [self areAllEnemiesDeadInArray]){
//        NSLog(@"victory");
//    }
}

#pragma mark - Methods Next Level Enemy Wave

- (BOOL)isNextWaveNeeded{
    return (numberLvl_ < kCountLevelWave - 1)?YES:NO;
}

- (BOOL)isNextWaveAvalible{
    return ([self areAllEnemiesDeadInArray] && ![self isEmptyArrayWithEnemies])?YES:NO;
}

- (void)prepareNextWave{
    numberLvl_++;
    
    [self clearEnemiesInArray];
}

- (void)createNextWave{
    [self prepareNextWave];
    
    [self createNextWaveTimer];
}

- (void)nextWave{
    [self createEnemies];
    
    [self startRespawnEnemiesTimer];
}

- (void)runEnemy{
    [self toRespawnPointCurrentEnemy];
    
    [self toNextEnemy];
    
    if([self isStopRespawnTimer]){
        [self stopRespawnTimer];
    }
}

#pragma mark - Methods Container(Array) Enemies

- (BOOL)isEmptyArrayWithEnemies{
    return enemies_ == nil;
}

- (void)createEnemies{
    enemies_ = [[NSMutableArray alloc] init];
    
    for(int i = 0;i < countEnemyCurrentWave_; i++){
        [enemies_ addObject:[self addEnemyForWaveLevel:numberLvl_]];
    }
    
    [self addManager];
}

- (void)addManager{
    for(TDEnemy *objectEnemy in enemies_){
        objectEnemy.manager = self;
    }

}

- (void)toRespawnPointCurrentEnemy{
    TDEnemy *currentEnemy = [enemies_ objectAtIndex:numEnemyStart_];
    [currentEnemy march];
}

- (void)toNextEnemy{
    numEnemyStart_--;
}

- (TDEnemy *)addEnemyForWaveLevel:(NSInteger)levelType{
    CGPoint respawnPoint = CGPointMake([[TDContainer sharedContainer] respawnCell].x + [[TDContainer sharedContainer] mapLevel].tileSize.width/2, [[TDContainer sharedContainer] respawnCell].y + [[TDContainer sharedContainer] mapLevel].tileSize.height/2);
    
    return [@{@(kSlayerLvl) : [[TDSlayer alloc] initWithRespawnPoint:respawnPoint delegate:mapDelegate_],
              @(kMinotaurLvl) : [[TDMinotaur alloc] initWithRespawnPoint:respawnPoint delegate:mapDelegate_],
              } objectForKey:@(levelType)];
}

- (BOOL)areAllEnemiesDeadInArray{
    BOOL anyLife = YES;
    if(![self isEmptyArrayWithEnemies]){
        for(TDEnemy *objectEnemy in enemies_){
            if(anyLife){
                anyLife = ![objectEnemy isLife];
            }
        }
    }
    return anyLife;
}

- (void)clearEnemiesInArray{
    [enemies_ removeAllObjects];
    enemies_ = nil;
}

#pragma mark - Timer Methods Wave

- (void)createNextWaveTimer{
    CGFloat timeInterval = waveInterval_ * numberLvl_;
    [_timerManager initTimer:timeInterval];
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(nextWave) userInfo:nil repeats:NO];
    [self incrementIntervalWave];
}

- (void)startRespawnEnemiesTimer{
    [_delegate setNumberWave:(numberLvl_ + 1) ofWaves:_countWaves];
    
    numEnemyStart_ = countEnemyCurrentWave_ - 1;

    timerRespawn_ = [NSTimer scheduledTimerWithTimeInterval:kTimeIntervalRespawnEnemy target:self selector:@selector(runEnemy) userInfo:nil repeats:YES];
}

- (BOOL)isStopRespawnTimer{
    return (numEnemyStart_ < kNumberLastObjectEnemy)?YES:NO;
}

- (void)pause{
    [self pauseTimer:timerRespawn_];
}

- (void)resume{
    [self resumeTimer:timerRespawn_];
}

- (void)pauseTimer:(NSTimer *)timer{
    _pauseStart = [NSDate dateWithTimeIntervalSinceNow:0];
    _previousFireDate = [timer fireDate];
    
    [timer setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer:(NSTimer *)timer{
    float pauseTime = -1 * [_pauseStart timeIntervalSinceNow];
    
    [timer setFireDate:[_previousFireDate initWithTimeInterval:pauseTime sinceDate:_previousFireDate]];
}

- (void)stopRespawnTimer{
    [timerRespawn_ invalidate];
    timerRespawn_ = nil;
}

- (void)incrementIntervalWave{
    waveInterval_ += kTimeIncrementIntervalBeetwenWave;
}

#pragma mark - TDRewardProtocol

- (void)reward:(NSInteger)rewardValue{
    [_coinsManager profit:rewardValue];
}

- (void)killWithOutReward:(NSInteger)damageValue{
    [_scoreManager catchDamage:damageValue];
}

@end
