//
//  TDTypeItem.m
//  Test
//
//  Created by dRumyankov on 7/8/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTypeItem.h"

@implementation TDTypeItem

+ (TypeItem)stringValueToType:(NSString *)value{
    if([value isEqualToString:@"kArcherTower"]){
        return kArcherTower;
    } else if([value isEqualToString:@"kCannonTower"]){
        return kCannonTower;
    } else if ([value isEqualToString:@"kEnergyTower"]){
        return kEnergyTower;
    } else if([value isEqualToString:@"kTeslaTower"]){
        return kTeslaTower;
    }
    
    return kClosedTower;
}

@end
