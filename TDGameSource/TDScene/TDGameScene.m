//
//  TDMainMenu.m
//  TowerDefense
//
//  Created by dRumyankov on 4/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDGameScene.h"
#import "TDContainer.h"

//Managers:
#import "TDTouchManager.h"
#import "TDEnemyWaveManager.h"
#import "TDBuildManager.h"
#import "TDTowerManager.h"
#import "TDCoinsManager.h"
#import "TDScoreManager.h"
#import "TDWaveTimerManager.h"

//Protocols:
#import "TDBuildProtocol.h"
#import "TDPauseProtocol.h"
#import "TDCoinsProtocol.h"
#import "TDScoreProtocol.h"
#import "TDWaveTimerProtocol.h"
#import "TDWaveProtocol.h"

//Categories:
#import "CCNode+CoordHelpers.h"

#define MAX_SCALE 1.3f
#define MIN_SCALE 1.0f

const CGFloat kDeltaZoom = 0.025f;

const CGFloat kQuarterOfValue = 0.25f;
const CGFloat kHalfOfValue = 0.5f;
const CGFloat kThreeQuarterOfValue = 0.75f;

const NSInteger kStartCountCoins = 480;
const NSInteger kStartCountEnergy = 10;
const NSInteger kStartCountLife = 20;

@interface TDGameScene() <TDBuildProtocol, TDPauseProtocol, TDCoinsProtocol, TDScoreProtocol, TDWaveTimerProtocol, TDWaveProtocol>

//TDGameScene:
@property (nonatomic) BOOL touchMove;

//TDManagers:
@property (nonatomic) TDEnemyWaveManager *enemyManager;
@property (nonatomic) TDBuildManager *buildManager;
@property (nonatomic) TDTowerManager *towerManager;
@property (nonatomic) TDCoinsManager *coinsManager;
@property (nonatomic) TDScoreManager *scoreManager;
@property (nonatomic) TDWaveTimerManager *timerManager;

//TDMap:
@property (nonatomic) CCTiledMap *tileMap;
@property (nonatomic) TDTiledMapCell *cellConstraction;

@end


@implementation TDGameScene

- (id)init{
    self = [super init];
    _touchMove = NO;
    _ccglView = (CCGLView *)[[CCDirector sharedDirector] view];
    
    _tileMap = [[TDContainer sharedContainer] mapLevel];
    
    [self setScenePosition];
    
    [self startRenderTimer];
    
    [self initManagers];
    
    [self addMap];
    
    [self addGestueRecognized];
    
    return self;
}

- (void)startRenderTimer{
    self.userInteractionEnabled = YES;
    _renderTimer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(updateScene) userInfo:nil repeats:YES];
}

- (BOOL)isNeedAdaptiveSizeSceen{
    CGSize mapSize = CGSizeMake(_tileMap.mapSize.width*_tileMap.tileSize.width, _tileMap.mapSize.height*_tileMap.tileSize.height);
    
    if(mapSize.width != _ccglView.frame.size.width){
        return YES;
    }
    
    return NO;
}

- (void)adaptiveSizeSceen{
    CGSize mapSize = CGSizeMake(_tileMap.mapSize.width*_tileMap.tileSize.width, _tileMap.mapSize.height*_tileMap.tileSize.height);
    
    CGFloat newScale = _ccglView.frame.size.width/mapSize.width;
    
    [_tileMap setScale:newScale];
}

- (void)addMap{
    
    if([self isNeedAdaptiveSizeSceen]){
        [self adaptiveSizeSceen];
    }
    
    CGSize newContentSize = CGSizeMake(_tileMap.mapSize.width*_tileMap.tileSize.width, _tileMap.mapSize.height*_tileMap.tileSize.height);
    [self setContentSize:newContentSize];
    [self addChild:_tileMap z:0];
}

- (void)initManagers{
    _coinsManager = [[TDCoinsManager alloc] initWithCoins:kStartCountCoins energy:kStartCountEnergy];
    _coinsManager.delegate = self;
    
    _scoreManager = [[TDScoreManager alloc] initWithHealth:kStartCountLife];
    _scoreManager.delegate = self;
    
    _timerManager = [[TDWaveTimerManager alloc] init];
    _timerManager.delegate = self;
    
    _enemyManager = [[TDEnemyWaveManager alloc] initWithMapDelegate:[[TDContainer sharedContainer] mapLevel]];
    _enemyManager.coinsManager = _coinsManager;
    _enemyManager.scoreManager = _scoreManager;
    _enemyManager.timerManager = _timerManager;
    _enemyManager.delegate = self;

    _buildManager = [[TDBuildManager alloc] initWithDelegate:self];
    _towerManager = [[TDTowerManager alloc] init];
}

- (void)setScenePosition{
    self.anchorPoint = ccp(kHalfOfValue,kHalfOfValue);
    self.positionType = CCPositionTypeNormalized;
    self.position = ccp(kHalfOfValue,kHalfOfValue);
    
    _tileMap.positionType = CCPositionTypeNormalized;
    _tileMap.position = ccp(kHalfOfValue, kHalfOfValue);
    _tileMap.anchorPoint = ccp(kHalfOfValue,kHalfOfValue);
}

- (void)stopRenderTimer{
    [_renderTimer invalidate];
    _renderTimer = nil;
}

- (void)updateScene{
    if(!self.paused){
        [_enemyManager render];
        [_towerManager scan:_enemyManager];
        
        //status bar manaegers:
        [_coinsManager update];
        
        if(![_scoreManager isHealthOver]){
            [_scoreManager update];
        } else {
            [self defeat];
        }
    } else {
        [self stopRenderTimer];
        [_enemyManager pause];
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{

}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInNode:_tileMap];

    if(!_touchMove){
        _cellConstraction = [TDTouchManager constractionCellByPoint:touchLocation];
        
        if(_cellConstraction){
            if(![_buildManager isShowBuildMenu]){
                if(!_cellConstraction.tower){
                    [_buildManager showBuildMenu:CGPointMake(_cellConstraction.x, _cellConstraction.y)];
                } else {
                    [_buildManager showBuildMenuForTower:_cellConstraction.tower inShowPoint:CGPointMake(_cellConstraction.x, _cellConstraction.y)];
                }
            } else {
                [self hideBuildMenu];
            }
        } else {
            if([_buildManager isShowBuildMenu]){
                [self hideBuildMenu];
            }
        }
    } else {
        _touchMove = NO;
    }
}

- (void)hideBuildMenu{
    _cellConstraction = [TDTouchManager constractionCellByPoint:[_buildManager menuPosition]];
    [_buildManager hideBuildMenu];
}

#pragma mark - TDBuildProtocol methods

- (void)runBuildObject:(TDItemTower *)typeTower{
    if(typeTower.typeItemBuild != kClosedTower){
        dispatch_async(dispatch_get_main_queue(), ^{
            CGPoint buildPoint = CGPointMake(_cellConstraction.x, _cellConstraction.y);
            TDTower *selectTower = [[TDTower alloc] initWithJSONObject:typeTower.tower inPoint:buildPoint];
            NSInteger needPower;
            
            if(_cellConstraction.tower){
                needPower = [selectTower valuePower] - [_cellConstraction.tower valuePower];
            } else {
                needPower = [selectTower valuePower];
            }
            
            NSLog(@"need power: %d", (int)needPower);
            
            needPower = 0;
            
            if([_coinsManager canMakePurchaseBuild:[selectTower valueCost] electricPower:needPower]){
                if(_cellConstraction.tower){
                    
                    [_coinsManager buy:[selectTower valueCost] energy:needPower];
                    [_cellConstraction.tower upgradeTower:typeTower.tower];
                    
                    //TO DO add animation upgrade
                    
                    
                } else {
                    _cellConstraction.tower = selectTower;
                    _cellConstraction.tower.delegate = (CCScene *)[[TDContainer sharedContainer] mapLevel];
                
                    [_coinsManager buy:[selectTower valueCost] energy:needPower];
                    [_cellConstraction.tower buildTower];
                
                    [_towerManager addTower:_cellConstraction.tower];
                }
            } else {
                if([_coinsManager isLackOfEnergy:needPower] && [_coinsManager isLackOfMoney:[selectTower valueCost]]){
                    [_statusBar animationNoMoney];
                    [_statusBar animationNoEnegry];
                } else if([_coinsManager isLackOfEnergy:[selectTower valuePower]]){
                    [_statusBar animationNoEnegry];
                } else if([_coinsManager isLackOfMoney:[selectTower valueCost]]){
                    [_statusBar animationNoMoney];
                }
            }
        });
    }
//    if(typeTower.typeItemBuild != kClosedTower){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            CGPoint buildPoint = CGPointMake(_cellConstraction.x, _cellConstraction.y);
//            //NSLog(@"build point %f - %f", buildPoint.x, buildPoint.y);
//            
//            TDTower *selectTower;
//            if(typeTower.typeItemBuild == kArcherTower){
//                selectTower = [[TDTowerArcher alloc] initWithPoint:buildPoint];
//            }
//            if(typeTower.typeItemBuild == kCannonTower){
//                selectTower = [[TDTowerCannon alloc] initWithPoint:buildPoint];
//            }
//            
//            if([_coinsManager canMakePurchaseBuild:[selectTower valueCost]]){
//                _cellConstraction.tower = selectTower;
//                _cellConstraction.tower.delegate = (CCScene *)[[TDContainer sharedContainer] mapLevel];
//                [_coinsManager buy:[selectTower valueCost]];
//                [_cellConstraction.tower buildTower];
//                
//                [_towerManager addTower:_cellConstraction.tower];
//            } else {
//                [_statusBar animationNoMoney];
//            }
//        });
//    }
}

- (void)correctivePosition:(CGPoint)position{    
    CGFloat rangeLeft = kHalfOfValue*self.scale;
    CGFloat rangeRight = kHalfOfValue*self.scale - (self.scale - MIN_SCALE);
    CGFloat rangeUp =  kQuarterOfValue*_tileMap.scale*self.scale - (_tileMap.scale - MIN_SCALE)*self.scale - (self.scale - MIN_SCALE);
    CGFloat rangeDown = _tileMap.scale*kThreeQuarterOfValue*self.scale;
    
    if(position.x > rangeLeft){
        position.x = rangeLeft;
    } else if(position.x < rangeRight){
        position.x = rangeRight;
    }
    
    if(position.y < rangeUp){
        position.y = rangeUp;
    } else if (position.y > rangeDown){
        position.y = rangeDown;
    }
    
    [self setPosition:position];
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGSize tileSize = CGSizeMake(_tileMap.mapSize.width*_tileMap.tileSize.width, _tileMap.mapSize.height*_tileMap.tileSize.height);
    _touchMove = YES;
    
    CGPoint location = [touch locationInView:_ccglView];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    CGPoint touchLocation = [touch locationInView:[touch view]];
    CGPoint prevLocation = [touch previousLocationInView:[touch view]];
    
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    prevLocation = [[CCDirector sharedDirector] convertToGL:prevLocation];

    CGPoint delta = ccpSub(touchLocation, prevLocation);
    CGPoint newPosition = CGPointMake(delta.x/tileSize.width, delta.y/tileSize.height);
    newPosition = ccpAdd(self.position, newPosition);
    
    [self correctivePosition:newPosition];
}

- (void)addGestueRecognized{
    _pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomScene:)];
    [_ccglView addGestureRecognizer:_pinch];
}

- (void)zoomScene:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    float newScale = self.scale + ((pinchGestureRecognizer.scale < MIN_SCALE)? - kDeltaZoom: kDeltaZoom);
    
    if(newScale > MAX_SCALE){
        self.scale = MAX_SCALE;
    } else if(newScale < MIN_SCALE){
        self.scale = MIN_SCALE;
    } else if (newScale > MIN_SCALE && newScale < MAX_SCALE){
        self.scale = newScale;
    }
    
    [self correctivePosition:self.position];
}

#pragma mark - TDPauseProtocol

- (void)pauseSceneActions:(id)sender{
    _statusBar = sender;
    self.userInteractionEnabled = NO;
    [self setPaused:YES];
}

- (void)resumeSceneActions{
    [[self parent] addChild:_statusBar];
    [self setPaused:NO];
    [self startRenderTimer];
    [_enemyManager resume];
}

- (void)clearScene{
    [self removeAllChildren];
    [self removeFromParent];
}

#pragma mark - TDCoinsProtocol

- (void)updateCoins:(NSInteger)newCoins{
    [_statusBar.coins setString:[NSString stringWithFormat:@"%d", (int)newCoins]];
}

- (void)updatePowerEnergy:(NSInteger)energy{
    [_statusBar.energy setString:[NSString stringWithFormat:@"%d", (int)energy]];
}

#pragma mark - TDScoreProtocol

- (void)updateScore:(NSInteger)newScore{
    [_statusBar.health setString:[NSString stringWithFormat:@"%d", (int)newScore]];
}

#pragma mark - TDWaveTimerProtocol

- (void)setValueTimer:(TDTime)time{
    NSString *dateFormat;
    
    if(time.seconds < 10){
        dateFormat = [NSString stringWithFormat:@"%d:0%d", time.minutes, time.seconds];
    } else {
        dateFormat = [NSString stringWithFormat:@"%d:%d", time.minutes, time.seconds];
    }
    
    [_statusBar.timer setString:dateFormat];
}

#pragma mark - TDWaveProtocol

- (void)setNumberWave:(NSInteger)number ofWaves:(NSInteger)countWaves{
    [_statusBar setNumberWave:number ofWaves:countWaves];
}

- (void)finishScreen{
    if(![_scoreManager isHealthOver]){
        [self victory];
    }
}

- (void)defeat{
    [self stopRenderTimer];
    CCScene *defeatScene = [CCBReader loadAsScene:@"TDDefeatScene"];
    
    [self loadFinishScreenWithChild:defeatScene];
}

- (void)victory{
    [self stopRenderTimer];
    CCScene *victoryScene = [CCBReader loadAsScene:@"TDVictoryScene"];
    
    [self loadFinishScreenWithChild:victoryScene];
}

- (void)loadFinishScreenWithChild:(CCScene *)child{
    CCNode *gameManagerScene = [self parent];
    [gameManagerScene addChild:child];
    
    [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(loadStartScene) userInfo:nil repeats:NO];
}

- (void)loadStartScene{
    [self clearScene];
    
    CCScene *menuScene = [CCBReader loadAsScene:@"TDMainScene"];
    [[CCDirector sharedDirector] replaceScene:menuScene];
}

@end
