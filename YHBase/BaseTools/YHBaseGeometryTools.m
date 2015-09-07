//
//  YHBaseGeometryTools.m
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHBaseGeometryTools.h"

@implementation YHBaseGeometryTools
+(CGSize)getLabelSize:(UILabel *)label inConstrainedSize:(CGSize)size{
    CGSize titleSize = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(size.width,size.height) lineBreakMode:NSLineBreakByWordWrapping];
    return titleSize;
}
@end
