//
//  TDTiledObject.m
//  Test
//
//  Created by dRumyankov on 6/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDObject.h"

@implementation TDObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class
                          fromJSON:(id)json{
    return [self arrayOfObjectsOfClass:obj_class
                                  fromJSON:json
                         postItrationBlock:nil];
}

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class
                          fromJSON:(id)json
                 postItrationBlock:(void (^) (TDObject *obj))block{
    NSMutableArray *resultValue = [NSMutableArray array];
        
    for(NSDictionary *info in json){
        TDObject *obj = [[obj_class alloc] initWithDictionary:info];
        
        [resultValue addObject:obj];
        if(block){
            block(obj);
        }
    }
    
    return  resultValue.count > 0 ? resultValue : nil;
}

@end
