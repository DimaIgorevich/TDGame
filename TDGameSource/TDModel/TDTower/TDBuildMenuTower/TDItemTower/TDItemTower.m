//
//  TDItemTower.m
//  TowerDefense
//
//  Created by dRumyankov on 5/13/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDItemTower.h"
#import "CCSprite+SizeToFit.h"

@implementation TDItemTower

- (id)init{
    if(self = [super init]){
        self.positionType = CCPositionTypePoints;
    }
    
    return self;
}

- (id)initWithTypeItem:(TypeItem)item delegate:(id<TDCloseProtocol>)delegate{
    if(self = [super init]){
        delegate_ = delegate;
        _typeItemBuild = item;
        [self sizeToFit];
        
        [self setSkin];
    }
    
    return self;
}

+ (TDItemTower *)itemTowerWithType:(TypeItem)item delegate:(id<TDCloseProtocol>)delegate{
    TDItemTower *itemTower = [[TDItemTower alloc] initWithTypeItem:item delegate:delegate];
    return itemTower;
}

- (void)setSkin{
    if(_typeItemBuild == kArcherTower){
        [self setSkinTower:@"td_tower_archers.png" background:kYellowSkinItem];
    } else if(_typeItemBuild == kCannonTower){
        [self setSkinTower:@"td_tower_cannon.png" background:kLightBlueSkinItem];
    } else if(_typeItemBuild == kClosedTower){
        [self setSkinTower:nil background:kCloseSkinItem];
    }

}

- (void)setSkinTower:(NSString *)nameOfFileTower background:(NSString *)nameOfFileBackground{
    CCButton *pButton = [[CCButton alloc] init];
    CCSpriteFrame *spriteFrame = [[CCSpriteFrame alloc] initWithTextureFilename:nameOfFileBackground rectInPixels:CGRectMake(0, 0, 32, 32) rotated:NO offset:CGPointMake(0, 0) originalSize:CGSizeMake(32, 32)];
    [pButton setBackgroundSpriteFrame:spriteFrame forState:CCControlStateNormal];
    pButton.preferredSizeType = CCSizeTypePoints;
    [pButton setPreferredSize:CGSizeMake(32, 32)];
    pButton.positionType = CCPositionTypeNormalized;
    pButton.position = CGPointMake(0.5f, 0.5f);
    
    pButton.scaleType = CCScaleTypeScaled;
    
    pButton.scaleX = [[CCDirector sharedDirector] view].frame.size.width/25.f;
    pButton.scaleY = [[CCDirector sharedDirector] view].frame.size.height/25.f;
    
    [pButton setTarget:self selector:@selector(touchInside)];

    [self addChild:pButton z:0];
    
    if(nameOfFileTower != nil){
        CCSprite *typeTower = [CCSprite spriteWithImageNamed:nameOfFileTower];
        typeTower.positionType = CCPositionTypeNormalized;
        typeTower.position = CGPointMake(0.5f, 0.5f);
        [typeTower sizeToCustomFit:CGSizeMake(28, 28)];
        
        [pButton addChild:typeTower z:1];
    }
    
}

- (void)sizeToFit{
    self.scaleX = 32/self.contentSize.width;
    self.scaleY = 32/self.contentSize.height;
}

- (BOOL)isItemSelected{
    return selected_;
}

- (void)touchInside{
    selected_ = YES;
    [delegate_ dismiss];
    //NSLog(@"tap %d", _typeItemBuild);
}

@end
