//
//  YHBaseTypesettingEngine.m
//  
//
//  Created by user on 15/8/24.
//
//

#import "YHBaseTypesettingEngine.h"
#import <Masonry/Masonry.h>
@interface YHBaseTypesettingEngine()
{
    NSMutableArray * _workImageArray;
    CGSize _size;
    UIView * _view;
}
@end
@implementation YHBaseTypesettingEngine


-(instancetype)initWithText:(NSString *)text{
    self = [super init];
    if (self) {
        _mainText = text;
        _workImageArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)setModelArray:(NSArray *)modelArray{
    _YHBaseTypesettingEngineModelArray = modelArray;
}

-(BOOL)startEngineInSize:(CGSize)size{
    _size=size;
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, 0)];
    for (int i = 0; i<_YHBaseTypesettingEngineModelArray.count; i++) {
        YHBaseTypesettingEngineModel * model = _YHBaseTypesettingEngineModelArray[i];
        switch (model.type) {
            case YHBaseTypesettingImage://imageView的替换
            {
                [self typesettingImageWithString:model.field];
            }
                break;
                
            default:
                break;
        }
    }
    return YES;
}
-(NSArray *)getTheTypesettingNode:(YHBaseTypesettingType)type{
    switch (type) {
        case YHBaseTypesettingImage:
        {
            return _workImageArray;
        }
            break;
            
        default:
            break;
    }
}

-(UIView *)getTheTypesettingView{
    return _view;
}

-(void)typesettingImageWithString:(NSString *)str{
    NSArray * array = [_mainText componentsSeparatedByString:str];
    for (int i=0; i<array.count; i++) {
        //创建label和image
        UILabel * label = [[UILabel alloc]init];
        label.text=array[i];
        label.numberOfLines=0;
        [_view addSubview:label];
        CGSize size = [YHBaseGeometryTools getLabelSize:label inConstrainedSize:CGSizeMake(_size.width, MAXFLOAT)];
        label.frame=CGRectMake(0, _view.frame.size.height, size.width+5, size.height);

        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, label.frame.size.height+5, size.width, 100)];
        [_workImageArray addObject:imageView];
        [_view addSubview:imageView];
        
        _view.frame=CGRectMake(20, 0, _view.frame.size.width, _view.frame.size.height+110+size.height);
    }
    
}

@end

@implementation YHBaseTypesettingEngineModel
@end

