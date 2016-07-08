//
//  TDLoadScene.m
//  Test
//
//  Created by dRumyankov on 6/15/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDLoadScene.h"
#import "TDGameScene.h"
#import "TDContainer.h"

@implementation TDLoadScene

- (void)startLoad{
    
    [self loadLevel:1];
    
    //4 sec
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(performToNextScene) userInfo:nil repeats:NO];
}

- (void)loadLevel:(NSInteger)numLevel{
    [[TDContainer sharedContainer] setMapLevel:[CCTiledMap tiledMapWithFile:[self mapFileNameByNumber:numLevel]]];
    
    [self loadMapObjects];
}

- (NSString *)mapFileNameByNumber:(NSInteger)numberLevel{
    return [@{
              @1 : @"td_level_1_map.tmx",
              @2 : @"td_level_2_map.tmx"
              } objectForKey:@(numberLevel)];
}

- (void)loadMapObjects{
    [self loadPath];
    [self loadConstraction];
    [self loadRespawnCell];
    [self loadTargetCell];
}

- (void)loadTargetCell{
    CCTiledMapObjectGroup *objectGroup = [[[TDContainer sharedContainer] mapLevel] objectGroupNamed:@"defend_point"];
    
    [[TDContainer sharedContainer] setTargetCell:[[TDObject arrayOfObjectsOfClass:[TDTiledMapCell class] fromJSON:[objectGroup objects]] firstObject]];
}

- (void)loadRespawnCell{
    CCTiledMapObjectGroup *objectGroup = [[[TDContainer sharedContainer] mapLevel] objectGroupNamed:@"start_point"];
    
    [[TDContainer sharedContainer] setRespawnCell:[[TDObject arrayOfObjectsOfClass:[TDTiledMapCell class] fromJSON:[objectGroup objects]] firstObject]];
}

- (void)loadPath{
    CCTiledMapObjectGroup *objectGroup = [[[TDContainer sharedContainer] mapLevel] objectGroupNamed:@"path"];
    
    [[TDContainer sharedContainer] setPathObjects:[TDObject arrayOfObjectsOfClass:[TDTiledMapCell class] fromJSON:[objectGroup objects]]];
}

- (void)loadConstraction{
    CCTiledMapObjectGroup *objectGroup = [[[TDContainer sharedContainer] mapLevel] objectGroupNamed:@"construction_points"];
    
    [[TDContainer sharedContainer] setConstractionObjects:[TDObject arrayOfObjectsOfClass:[TDTiledMapCell class] fromJSON:[objectGroup objects]]];
}

- (void)performToNextScene{
    CCScene *managerGameScene = [CCBReader loadAsScene:@"TDGameSceneManager"];
    [[CCDirector sharedDirector] replaceScene:managerGameScene];
}

@end
