//
//  MapScheme.m
//  TowerDefense
//
//  Created by dRumyankov on 4/29/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "MapScheme.h"

const NSInteger hMapScheme = 11;
const NSInteger wMapScheme = 20;

int mapScheme[hMapScheme][wMapScheme] = {
    {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    {1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1},
    {1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1},
    {1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1},
    {1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1},
    {1,2,2,1,1,2,2,2,2,2,2,2,2,2,2,1,2,1,1,1},
    {1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,2,1,1,1},
    {1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,2,2,2,2},
    {1,1,2,1,1,2,1,1,1,2,2,2,2,2,2,1,1,1,1,1},
    {1,1,2,2,2,2,1,1,1,2,1,1,1,1,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1}
};

@implementation MapScheme

+ (int)cellByIndexs:(int)x y:(int)y{
    return mapScheme[x][y];
}

+ (NSInteger)hMapScheme{
    return hMapScheme;
}

+ (NSInteger)wMapScheme{
    return wMapScheme;
}

@end
