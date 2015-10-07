//
//  MyModel.h
//  YHBaseFoundationTest
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 jaki.zhang. All rights reserved.
//

#import "YHBaseModel.h"

@interface MyModel : YHBaseModel
__PROPERTY_NO_ASSIGN__(int, age);
__PROPERTY_NO_STRONG__(NSString *, name);
@end
