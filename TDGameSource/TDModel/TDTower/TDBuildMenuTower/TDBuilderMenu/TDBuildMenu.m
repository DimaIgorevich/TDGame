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

const CGPoint kUpLeftPosition = {-8.0f, 100.0f - 24.0f};
const CGPoint kDownLeftPosition = {-8.0f, -8.0f};
const CGPoint kUpRightPosition = {100.0f - 24.0f, 100.0f - 24.0f};
const CGPoint kDownRightPosition = {100.0f - 24.0f, -8.0f};
const CGPoint kDownMidPosition = {50.0f - 16.0f, -8.0f};
const CGPoint kUpMidPosition = {50.0f - 16.0f, 100.f -24.0f};

@implementation TDBuildMenu{
    id<TDCloseProtocol> manager_;
}

- (id)initWithManager:(id<TDCloseProtocol>)manager{
    if(self = [super initWithImageNamed:kBaseSkinBuildMenu]){
        self.scale = 0.0f;
        
        manager_ = manager;
        
        _itemBuildColletion = [NSArray arrayWithObjects:[TDItemTower itemTowerWithType:kArcherTower delegate:manager], [TDItemTower itemTowerWithType:kCannonTower delegate:manager], [TDItemTower itemTowerWithType:kClosedTower delegate:manager], nil];
        
        [self setPositionOnMenu];
        [self addChilds];
    }
    return self;
}

- (id)initWithJSONObjects:(NSArray <TDTowerJSON *>*)jsonObjects manager:(id<TDCloseProtocol>)manager{
    if(self = [super initWithImageNamed:kBaseSkinBuildMenu]){
        self.scale = 0.0f;
        manager_ = manager;
        
        _itemBuildColletion = [NSArray arrayWithArray:[self menuItems:jsonObjects]];
        
        [self setPositionOnMenu];
        [self addChilds];
    }
    return self;
}

- (NSArray *)menuItems:(NSArray <TDTowerJSON *>*)jsonTowers{
    NSMutableArray <TDItemTower *>*items = [[NSMutableArray alloc] init];
    for(TDTowerJSON *jsonObject in jsonTowers){
        [items addObject:[TDItemTower itemWithJSONTowerObject:jsonObject delegate:manager_]];
    }
    return items;
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
    if(_itemBuildColletion.count > 2){
        if(index == 0){
            point = kUpLeftPosition;
        } else if(index == 1){
            point = kUpRightPosition;
        } else if(index == 2){
            point = kDownLeftPosition;
        } else if(index == 3){
            point = kDownRightPosition;
        }
    } else {
        if(index == 0){
            point = kUpMidPosition;
        } else if(index == 1){
            point = kDownMidPosition;
        }
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
