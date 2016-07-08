//
//  TDPriceBoard.m
//  Test
//
//  Created by dRumyankov on 7/4/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDPriceBoard.h"

const CGFloat fontSize = 56.0f;

@implementation TDPriceBoard

- (id)initWithPriceBuilding:(NSInteger)price{
    if(self = [super initWithImageNamed:@"priceBoard.png"]){
        self.scale = 2;
        self.anchorPoint = ccp(0.5f, 0.5f);
        
        self.positionType = CCPositionTypeNormalized;
        self.position = ccp(0.5f, -0.35f);
        
        priceBuilding_ = price;
        [self setPriceLabel];
    }
    
    return self;
}

- (void)setPriceLabel{
    NSString *stringPrice = [NSString stringWithFormat:@"%d", (int)priceBuilding_];
    NSString *fontName = @"Futura-CondensedExtraBold";
    
    priceLabel_ = [CCLabelTTF labelWithString:stringPrice fontName:fontName fontSize:fontSize];
    [priceLabel_ setColor:[CCColor colorWithUIColor:[UIColor blackColor]]];
    
    priceLabel_.positionType = CCPositionTypeNormalized;
    priceLabel_.position = ccp(0.5f,0.35f);
    
    [self addChild:priceLabel_];
}

@end
