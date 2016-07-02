//
//  TDPauseMenuLayer.h
//  Test
//
//  Created by dRumyankov on 6/30/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "TDPauseProtocol.h"

@interface TDPauseMenuLayer : CCNode

@property (nonatomic) id<TDPauseProtocol> gameScene;

@end
