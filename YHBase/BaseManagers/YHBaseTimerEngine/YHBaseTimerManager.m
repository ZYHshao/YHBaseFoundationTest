//
//  YHBaseTimerManager.m
//  
//
//  Created by user on 15/8/31.
//
//

#import "YHBaseTimerManager.h"
#import "YHBaseTimerNode.h"

@implementation YHBaseTimerManager
{
    NSTimer * _timer;
    NSMutableArray * _actionArray;
    int _count;
}
+(instancetype)sharedTheSingletion{
    static YHBaseTimerManager * manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        _actionArray=[[NSMutableArray alloc]init];
        _count=0;

    }
    return self;
}
-(void)timerAction{
    if (_count<59) {
        _count++;
    }else{
        _count=0;
    }
    for  (int i=(int)_actionArray.count-1; i>=0;i--) {
        YHBaseTimerNode * action = _actionArray[i];
        if (action.shouldRemove) {
            [_actionArray removeObject:action];
            continue;
        }
        NSAssert((60%action.timer)==0, @"the timer must been devisible to 60");
        if (action.isValid&&(_count%(60/action.timer))==0) {
            action.callback();
        }
    }
}

-(void)registerAction:(void (^)())action timer:(int)timer andName:(NSString *)name{
    YHBaseTimerNode * node=[[YHBaseTimerNode alloc]init];
    node.callback=action;
    node.timer=timer;
    node.isValid=YES;
    node.shouldRemove=NO;
    node.name=name;
    [_actionArray addObject:node];
}
-(void)setValid:(BOOL)isvalid toName:(NSString *)name{
    for (YHBaseTimerNode *a in _actionArray) {
        if ([a.name isEqualToString:name]) {
            a.isValid=isvalid;
        }
    }
}
-(void)upDataGameEngineTimer:(int)timer ForName:(NSString *)name{
    for (YHBaseTimerNode *a in _actionArray) {
        if ([a.name isEqualToString:name]) {
            a.timer=timer;
        }
    }
}
-(void)stopAllAction{
    for (YHBaseTimerNode *a in _actionArray) {
        if(a.isValid)
            a.isValid=NO;
    }
}
-(void)beginAllAction{
    for (YHBaseTimerNode *a in _actionArray) {
        a.isValid=YES;
    }
}
-(void)removeActionForName:(NSString *)name{
    for (YHBaseTimerNode *a in _actionArray) {
        if ([a.name isEqualToString: name]) {
                a.shouldRemove=YES;
        }
    
    }
}

@end
