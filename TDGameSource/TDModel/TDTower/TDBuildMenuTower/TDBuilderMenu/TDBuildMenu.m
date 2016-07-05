//
//  TDBuildMenu.m
//  TowerDefense
//
//  Created by dRumyankov on 5/13/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDBuildMenu.h"
#import "TDContainer.h"

#define kBaseSkinBuildMenu @"td_build_menu_base.png"

@implementation TDBuildMenu

- (id)initWithManager:(id<TDCloseProtocol>)manager{
    if(self = [super initWithImageNamed:kBaseSkinBuildMenu]){
        self.scale = 0.0f;
        
        _itemBuildColletion = [NSArray arrayWithObjects:[TDItemTower itemTowerWithType:kArcherTower delegate:manager], [TDItemTower itemTowerWithType:kCannonTower delegate:manager], [TDItemTower itemTowerWithType:kClosedTower delegate:manager], nil];
        
        [self setPositionOnMenu];
        [self addChilds];
    }
    return self;
}

- (void)show{
    [[[TDContainer sharedContainer] mapLevel] addChild:self z:10];
    [self effectFadeIn];
}

- (void)hide{
    [self senderProtocol];
    [self effectFunction_FadeOut];
}

- (void)effectFadeIn{
    dispatch_sync(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self runAction:[[CCActionScaleTo alloc] initWithDuration:0.3f scale:1.0f]];
        [self runAction:[[CCActionFadeIn alloc] initWithDuration:0.3f]];
    });
}

- (void)effectFunction_FadeOut{
    dispatch_sync(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self runAction:[[CCActionScaleTo alloc] initWithDuration:0.3f scale:0.0f]];
        [self runAction:[[CCActionFadeOut alloc] initWithDuration:0.3f]];
    });
}

- (void)setPositionOnMenu{
    for(TDItemTower *objectTower in _itemBuildColletion){
        objectTower.position = [self rectPositionByIndex:[_itemBuildColletion indexOfObject:objectTower]];
    }
}

- (CGPoint)rectPositionByIndex:(NSInteger)index{
    CGPoint point;
    if(index == 0){
        point = CGPointMake(-8,-8);
    } else if(index == 1){
        point = CGPointMake(-8.0f, 100.0f - 24.0f);
    } else if(index == 2){
        point = CGPointMake(100.0f - 24.0f, 100.0f - 24.0f);
    }
    return point;
}

- (void)addChilds{
    for(TDItemTower *objectTower in _itemBuildColletion){
        [self addChild:objectTower z:2];
    }
}

+ (CGRect)showFrame:(CGPoint)showPoint{
    CGSize cellSize = [[TDContainer sharedContainer] mapLevel].tileSize;
    return CGRectMake(showPoint.x + cellSize.width/2, showPoint.y + cellSize.height/2, 100, 100);
}

- (void)senderProtocol{
    TDItemTower *selectedTowerItem = [self selectedTowerItem];
    
    if(selectedTowerItem != nil){
        //NSLog(@"build protocol RUN!!!");
        [_delegate runBuildObject:selectedTowerItem];
    }
}

- (TDItemTower *)selectedTowerItem{
    TDItemTower *selectedItemTower = nil;
    for(TDItemTower *objectTower in _itemBuildColletion){
        if([objectTower isItemSelected]){
            return objectTower;
        }
    }
    return selectedItemTower;
}

@end
