//
//  TDTiledMapCell.m
//  Test
//
//  Created by dRumyankov on 6/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDTiledMapCell.h"

@implementation TDTiledMapCell

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    
    if(self){
        _height = [[dictionary objectForKey:@"height"] floatValue];
        _width = [[dictionary objectForKey:@"width"] floatValue];
        _x = [[dictionary objectForKey:@"x"] floatValue];
        _y = [[dictionary objectForKey:@"y" ] floatValue];
    }
    
    return self;
}

@end
