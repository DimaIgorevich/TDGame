//
//  TDItemTower.h
//  TowerDefense
//
//  Created by dRumyankov on 5/13/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDCloseProtocol.h"
#import "TDTowerJSON.h"

#define kYellowSkinItem @"td_build_menu_yellow_item.png"
#define kGreenSkinItem @"td_build_menu_green_item.png"
#define kLightBlueSkinItem @"td_build_menu_light_blue_item.png"
#define kWhiteSkinItem @"td_build_menu_white_item.png"
#define kCloseSkinItem @"td_build_menu_closed_item.png"

@interface TDItemTower : CCScene{
    BOOL selected_;

    id<TDCloseProtocol> delegate_;
}

@property (nonatomic) TDTowerJSON *tower;
@property (nonatomic) TypeItem typeItemBuild;

- (id)initWithTypeItem:(TypeItem)item delegate:(id<TDCloseProtocol>)delegate;
- (id)initWithJSONObject:(TDTowerJSON *)jsonTower delegate:(id<TDCloseProtocol>)delegate;

- (BOOL)isItemSelected;

+ (TDItemTower *)itemTowerWithType:(TypeItem)item delegate:(id<TDCloseProtocol>)delegate;
+ (TDItemTower *)itemWithJSONTowerObject:(TDTowerJSON *)jsonObject delegate:(id<TDCloseProtocol>)delegate;

@end
