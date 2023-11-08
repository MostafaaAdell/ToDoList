//
//  ModelNetwork.h
//  ToDoList
//
//  Created by Mustafa on 31/08/2023.
//

#import <Foundation/Foundation.h>
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModelNetwork : NSObject
@property NSUserDefaults *toDoAppTasks;
@property NSMutableArray<Model*> *modelList;
@property NSMutableArray <Model*> *listView;
@property NSMutableArray <Model*> *highPrioty;
@property NSMutableArray <Model *> *meduimPrio;
@property NSMutableArray <Model *> *lowPrio;
@property int flag;
@property int isSort;



-(void)loadModeList;
-(void)filterDataAccordingToStatus:(int)Status withPredicate:(NSString*) condition;
-(void)removeCertainTaskWithIndex:(int) index WithSection:(int)section withStatus:(int)status withPredicate:(NSString *)condition;

-(void)setModelList;
-(void)filterAccordingPriority;

@end

NS_ASSUME_NONNULL_END
