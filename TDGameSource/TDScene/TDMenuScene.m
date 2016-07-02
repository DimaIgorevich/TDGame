//
//  TDMenuScene.m
//  Test
//
//  Created by dRumyankov on 6/15/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TDMenuScene.h"
#import "TDLoadScene.h"

@implementation TDMenuScene

- (void)start:(id)sender{
    NSLog(@"start");
    CCScene *loadScene = [CCBReader loadAsScene:@"TDLoadScene"];
    [((TDLoadScene*)[loadScene.children firstObject]) startLoad];
    
    [[CCDirector sharedDirector] replaceScene:loadScene];
    //    CCScene *game = [[TDMenuScene alloc] init];
    //    [[CCDirector sharedDirector] replaceScene:game];
    
}

- (void)credits:(id)sender{
    NSLog(@"credits");
    CCScene *creditsScene = [CCBReader loadAsScene:@"TDCredits"];
    [[CCDirector sharedDirector] replaceScene:creditsScene];
}

@end
