//
//  TDBuildMenu.h
//  TowerDefense
//
//  Created by dRumyankov on 5/13/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDItemTower.h"
#import "TDBuildProtocol.h"
#import "TDCloseProtocol.h"

@interface TDBuildMenu : CCSprite

@property (nonatomic) id<TDBuildProtocol> delegate;
@property (nonatomic) NSArray <TDItemTower *>* itemBuildColletion;

- (id)initWithManager:(id<TDCloseProtocol>)manager;

- (void)show;
- (void)hide;

+ (CGRect)showFrame:(CGPoint)showPoint;

@end
