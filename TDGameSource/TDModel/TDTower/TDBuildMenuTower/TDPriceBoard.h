//
//  TDPriceBoard.h
//  Test
//
//  Created by dRumyankov on 7/4/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface TDPriceBoard : CCSprite{
    NSInteger priceBuilding_;
    CCLabelTTF *priceLabel_;
}

- (id)initWithPriceBuilding:(NSInteger)price;

@end
