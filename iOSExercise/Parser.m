//
//  Parser.m
//  iOSExercise
//
//  Created by Ramesh K on 23/11/15.
//  Copyright © 2015 Ramesh K. All rights reserved.
//

#import "Parser.h"
#import "Facts.h"

@implementation Parser

-(NSMutableArray *) ParseJsonToFacts:(NSArray *)data
{
    NSMutableArray *arrFacts = [[NSMutableArray alloc] init];
    
    for(NSDictionary *fact in data)
    {
        Facts *facObj = [[Facts alloc] init];
        
        facObj.strTitle = [fact objectForKey:@"title"];
        if([fact objectForKey:@"description"] != nil && ![[fact objectForKey:@"description"] isEqual:[NSNull null]])
            facObj.strDescription = [fact objectForKey:@"description"];
        else
            facObj.strDescription  = @"";
        
        if([fact objectForKey:@"imageHref"] != nil && ![[fact objectForKey:@"imageHref"] isEqual:[NSNull null]])
            facObj.strImgUrl = [fact objectForKey:@"imageHref"];
        else
            facObj.strImgUrl = @"";
        
        [arrFacts addObject:facObj];
    }
    return arrFacts;
}

@end
