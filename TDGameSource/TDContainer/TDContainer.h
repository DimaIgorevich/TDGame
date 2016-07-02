//
//  TDContainer.h
//  TowerDefense
//
//  Created by dRumyankov on 5/20/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTiledMapCell.h"
#import "TDEnemy.h"

#import "TDGameScene.h"

@interface TDContainer : NSObject{
    NSMutableArray <TDEnemy *> *enemies_;
    CCTiledMap *mapLevel_;
    NSArray <TDTiledMapCell *>* pathObjects_;
    NSArray <TDTiledMapCell *>* constractionObjects_;
    
    TDTiledMapCell *respawnCell_;
    TDTiledMapCell *targetCell_;
}

@property (nonatomic) NSMutableArray <TDEnemy *> *enemies;
@property (nonatomic) CCTiledMap *mapLevel;
@property (nonatomic) NSArray <TDTiledMapCell *>* pathObjects;
@property (nonatomic) NSArray <TDTiledMapCell *>* constractionObjects;

@property (nonatomic) TDTiledMapCell *respawnCell;
@property (nonatomic) TDTiledMapCell *targetCell;

+ (id)sharedContainer;

- (void)setMapLevel:(CCTiledMap *)mapLevel;
- (void)setPathObjects:(NSArray<TDTiledMapCell *> *)pathObjects;
- (void)setConstractionObjects:(NSArray<TDTiledMapCell *> *)constractionObjects;

@end
