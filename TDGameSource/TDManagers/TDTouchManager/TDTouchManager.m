//
//  TDTouchManager.m
//  Test
//
//  Created by dRumyankov on 6/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTouchManager.h"
#import "TDContainer.h"

@implementation TDTouchManager

+ (TDTiledMapCell *)constractionCellByPoint:(CGPoint)location{
    CGPoint touchLocation = [self adaptivePoint:location];
    for(TDTiledMapCell *objectCell in [[TDContainer sharedContainer] constractionObjects]){
        if(objectCell.x == touchLocation.x && objectCell.y == touchLocation.y){
            return objectCell;
        }
    }
    return nil;
}

+ (CGPoint)adaptivePoint:(CGPoint)point{
    CCTiledMap *_tileMap = [[TDContainer sharedContainer] mapLevel];
    
    return CGPointMake(_tileMap.tileSize.width*((int)(point.x / _tileMap.tileSize.width)), _tileMap.tileSize.height*((int)(point.y / _tileMap.tileSize.height)));
}

@end
