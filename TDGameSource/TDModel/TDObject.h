//
//  TDTiledObject.h
//  Test
//
//  Created by dRumyankov on 6/24/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDObject : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class
                          fromJSON:(id)json;
+ (NSArray *)arrayOfObjectsOfClass:(Class)obj_class
                          fromJSON:(id)json
                 postItrationBlock:(void (^) (TDObject *obj))block;

@end
