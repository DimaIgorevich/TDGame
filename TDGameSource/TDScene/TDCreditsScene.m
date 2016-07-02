//
//  TDCreditsScene.m
//  Test
//
//  Created by dRumyankov on 6/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//


//TDCreditsScene
#import "TDCreditsScene.h"

@implementation TDCreditsScene

- (void)back:(id)sender{
    CCScene *backScene = [CCBReader loadAsScene:@"TDMainScene"];
    [[CCDirector sharedDirector] replaceScene:backScene];
}

@end
