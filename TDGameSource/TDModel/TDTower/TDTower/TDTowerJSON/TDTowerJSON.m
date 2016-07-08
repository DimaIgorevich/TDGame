//
//  TDTowerJSON.m
//  Test
//
//  Created by dRumyankov on 7/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTowerJSON.h"

@implementation TDTowerJSON

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if(self = [super initWithDictionary:dictionary]){      
        _fileNameTowerSprite = [dictionary objectForKey:@"towerSprite"];
        _upgradeLevel = [[dictionary objectForKey:@"upgradeLevel"] integerValue];
        _typeTower = [TDTypeItem stringValueToType:[dictionary objectForKey:@"typeTower"]];
        _damage = [[dictionary objectForKey:@"damage"] integerValue];
        _cost = [[dictionary objectForKey:@"cost"] integerValue];
        _speedBullet = [[dictionary objectForKey:@"speedBullet"] integerValue];
        _coolDown = [[dictionary objectForKey:@"coolDown"] floatValue];
        _radius = [[dictionary objectForKey:@"radius"] floatValue];
    }
    return self;
}

@end
