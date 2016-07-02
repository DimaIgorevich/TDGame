//
//  TDMapCell.h
//  TowerDefense
//
//  Created by dRumyankov on 4/22/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDAnimationSheet.h"
#import "TDTower.h"
#import "TDTowerArcher.h"
#import "TDTowerCannon.h"

//enum type cell

typedef enum {
    kStartCell,
    kContructionCell,
    kPathCell,
    kBlockCell,
    kDefendCell
} MapCellType;

@interface TDMapCell : NSObject {
    //map cell:
    CCSprite *spriteCell_;
    TDTower *tower_;
    
    //property cell:
    CGSize cellSizeTile_;
    CGPoint cellPosition_;
    
    //type cell:
    MapCellType cellType_;
    
    //touch:
    CCTouch *tapCell_;
}

@property (nonatomic) CCSprite *spriteCell;
@property (nonatomic) TDTower *tower;

- (id)initWithType:(MapCellType)cellType position:(CGPoint)cellPosition;

- (CCSprite *)displayChild;

- (CGPoint)cellPosition;
- (MapCellType)cellType;

+ (CGSize)sizeMapCell;

- (BOOL)isConstructionCell;

@end
