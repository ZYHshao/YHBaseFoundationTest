//
//  YHBaseCoreGraphicsTools.m
//  
//
//  Created by user on 15/8/25.
//
//

#import "YHBaseCoreGraphicsTools.h"

@implementation YHBaseCoreGraphicsTools
CGPoint YHBaseMiddlePoint(CGPoint p1,CGPoint p2){
    return CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
}
@end
