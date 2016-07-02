//
//  TDContainer.m
//  TowerDefense
//
//  Created by dRumyankov on 5/20/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDContainer.h"

@implementation TDContainer

@synthesize enemies = enemies_;
@synthesize mapLevel = mapLevel_;
@synthesize pathObjects = pathObjects_;
@synthesize constractionObjects = constractionObjects_;

@synthesize respawnCell = respawnCell_;
@synthesize targetCell = targetCell_;

+ (id)sharedContainer{
    static TDContainer *sharedContainer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedContainer = [[self alloc] init];
    });
    return sharedContainer;
}

- (id)init{
    if(self = [super init]){
        enemies_ = [[NSMutableArray alloc] init];
        mapLevel_ = [[CCTiledMap alloc] init];
        pathObjects_ = [[NSArray alloc] init];
        constractionObjects_ = [[NSArray alloc] init];
        
        respawnCell_ = [[TDTiledMapCell alloc] init];
        targetCell_ = [[TDTiledMapCell alloc] init];
    }
    return self;
}

- (void)setMapLevel:(CCTiledMap *)mapLevel{
    mapLevel_ = mapLevel;
}

- (void)setPathObjects:(NSArray<TDTiledMapCell *> *)pathObjects{
    pathObjects_ = pathObjects;
}

- (void)setConstractionObjects:(NSArray<TDTiledMapCell *> *)constractionObjects{
    constractionObjects_ = constractionObjects;
}

@end
