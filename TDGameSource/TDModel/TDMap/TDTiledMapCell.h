//
//  TDTiledMapCell.h
//  Test
//
//  Created by dRumyankov on 6/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDTower.h"
#import "TDTiledObject.h"

@interface TDTiledMapCell : TDTiledObject

@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) TDTower *tower;

@end
