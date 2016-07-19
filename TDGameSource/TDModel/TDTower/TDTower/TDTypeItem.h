//
//  TDTypeItem.h
//  Test
//
//  Created by dRumyankov on 7/8/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    kArcherTower,
    kCannonTower,
    kEnergyTower,
    kTeslaTower,
    kClosedTower
}TypeItem;

@interface TDTypeItem : NSObject

+ (TypeItem)stringValueToType:(NSString *)value;

@end
