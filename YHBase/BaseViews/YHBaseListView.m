//
//  YHBaseListView.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHBaseListView.h"
#import "YHBaseListViewItem.h"
@implementation YHBaseListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//初始化的方法写在这个函数中
-(void)reloadView{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds=YES;
    
}

-(void)setItemsArray:(NSArray *)itemsArray{
    _itemsArray = nil;
    _itemsArray = [[NSArray alloc]initWithArray:itemsArray];
    //进行视图的重新布局
    [self creatViewWithData:itemsArray];
}

-(void)creatViewWithData:(id)data{
    NSAssert([data isKindOfClass:[NSArray class]], @"must deliver class of NSArray to itemsArray");
    NSArray * array = (NSArray *)data;
    for(int i=0;i<array.count;i++){
        if (_itemHight<30.0) {
            _itemHight = 30.0;
        }
        NSAssert([array[i] isKindOfClass:[YHBaseListViewItem class]], @"must deliver class of YHBaseListViewItem to itemsArray");
        YHBaseListViewItem * item = array[i];
        item.frame = CGRectMake(0, _itemHight*i, self.frame.size.width, _itemHight);
        item.titleLabel.frame=CGRectMake(_itemHight, 0, self.frame.size.width-_itemHight, _itemHight);
        item.titleImageView.frame=CGRectMake(10, 5, _itemHight-10, _itemHight-10);
        item.action=^(){
            if ([self.delegate respondsToSelector:@selector(YHBaseListViewClickAtIndex:)]) {
                [self.delegate YHBaseListViewClickAtIndex:i];
            }
        };
        [self addSubview:item];
    }
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _itemHight*array.count);
    self.alpha=0;
}

-(void)openList{
    __BLOCK__WEAK__SELF__(__self);
    [UIView animateWithDuration:0.3 animations:^{
        [__self setAlpha:1];
    }];
    _isShow=YES;
}

-(void)closeList{
    __BLOCK__WEAK__SELF__(__self);
    [UIView animateWithDuration:0.3 animations:^{
        [__self setAlpha:0];
    }];
    _isShow=NO;
}

@end
