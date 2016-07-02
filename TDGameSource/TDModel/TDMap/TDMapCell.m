//
//  TDMapCell.m
//  TowerDefense
//
//  Created by dRumyankov on 4/22/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDMapCell.h"

const CGFloat kWidthTileCell = 30.0f;
const CGFloat kHeightTileCell = 30.0f;

@implementation TDMapCell

@synthesize spriteCell = spriteCell_;
@synthesize tower = tower_;

- (id)initWithType:(MapCellType)cellType position:(CGPoint)cellPosition{
    if(self = [super init]){
        
        cellPosition_ = cellPosition;
        cellType_ = cellType;
        cellSizeTile_ = CGSizeMake(kWidthTileCell, kHeightTileCell);
        
        [self setSpriteForCell];
    }
    return self;
}

- (void)setSpriteForCell{
    if(cellType_ == kContructionCell){
        spriteCell_ = [CCSprite spriteWithImageNamed:@"td_block_element.png"];
        tapCell_ = [[CCTouch alloc] init];

        
    }
    if(cellType_ == kPathCell){
        spriteCell_ = [CCSprite spriteWithImageNamed:@"td_path_element.png"];
    }
    
    [spriteCell_ setContentSize:CGSizeMake(30, 30)];
    spriteCell_.anchorPoint = CGPointZero;
    spriteCell_.position = cellPosition_;
}

- (CCSprite *)displayChild{
    return spriteCell_;
}

- (CGPoint)cellPosition{
    return cellPosition_;
}

- (MapCellType)cellType{
    return cellType_;
}

+ (CGSize)sizeMapCell{
    return CGSizeMake(kWidthTileCell, kHeightTileCell);
}

- (BOOL)isConstructionCell{
    if(cellType_ == kContructionCell){
        return YES;
    }
    return NO;
}

//tap:

- (void)tapCell{
    NSLog(@"taps");
}

@end
