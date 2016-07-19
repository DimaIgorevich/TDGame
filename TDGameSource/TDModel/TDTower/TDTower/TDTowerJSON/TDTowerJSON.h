//
//  TDTowerJSON.h
//  Test
//
//  Created by dRumyankov on 7/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDObject.h"
#import "TDTypeItem.h"

@interface TDTowerJSON : TDObject

@property (nonatomic) NSString *fileNameTowerSprite;
@property (nonatomic) NSInteger upgradeLevel;
@property (nonatomic) TypeItem typeTower;
@property (nonatomic) NSInteger damage;
@property (nonatomic) NSInteger cost;
@property (nonatomic) NSInteger power;
@property (nonatomic) NSInteger speedBullet;
@property (nonatomic) CGFloat coolDown;
@property (nonatomic) CGFloat radius;

@end
