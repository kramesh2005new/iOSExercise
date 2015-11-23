//
//  Parser.h
//  iOSExercise
//
//  Created by Ramesh K on 23/11/15.
//  Copyright © 2015 Ramesh K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

-(NSMutableArray *) ParseJsonToFacts:(NSArray *)data;

@end
