//
//  TDJSONObject.m
//  Test
//
//  Created by dRumyankov on 7/8/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDJSONObjects.h"

#define jsonFileType @"json"

@implementation TDJSONObjects : NSObject 

+ (NSArray *)jsonObjectsFromFile:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:jsonFileType];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonObjects = (NSArray *)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return jsonObjects;
}

@end
