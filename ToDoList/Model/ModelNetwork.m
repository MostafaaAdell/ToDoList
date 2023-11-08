//
//  ModelNetwork.m
//  ToDoList
//
//  Created by Mustafa on 31/08/2023.
//

#import "ModelNetwork.h"

@implementation ModelNetwork
 NSString *listName = @"List";


- (instancetype)init{
    
    self = [super init];
    _toDoAppTasks = [NSUserDefaults standardUserDefaults];
    _modelList = [[NSMutableArray alloc] init];
    _listView =[[NSMutableArray alloc] init];
    _highPrioty =[[NSMutableArray alloc] init];
    _meduimPrio = [[NSMutableArray alloc] init];
    _lowPrio = [[NSMutableArray alloc] init];
    _flag = 0;
    _isSort = 0;

    
    
    return self;
}

- (void)loadModeList{
    
    NSError *error;
    NSData *dataSaved = [_toDoAppTasks objectForKey:listName];
    NSSet *set = [NSSet setWithArray:@[[NSMutableArray class],[Model class]]];
    if(dataSaved!=nil)
    _modelList = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:dataSaved error:&error];
}

- (void)setModelList{
    
    
       NSError *error;
       NSData *dataRetrived = [NSKeyedArchiver archivedDataWithRootObject:_modelList requiringSecureCoding:YES error:&error];
       [_toDoAppTasks setObject:dataRetrived forKey:listName];
       
}



- (void)filterDataAccordingToStatus:(int)Status withPredicate:(nonnull NSString *)condition{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:condition, Status];
    NSArray *filteredArray  = [_modelList filteredArrayUsingPredicate:predicate];
    _listView = [NSMutableArray arrayWithArray:filteredArray];
   
}



-(void)removeCertainTaskWithIndex:(int)index WithSection:(int)section withStatus:( int)status withPredicate:(nonnull NSString *)condition{
    
    Model *deletedItem = [Model new];
    if(_isSort){
        switch(section){
            case 0:
                deletedItem = _highPrioty[index];
                break;
            case 1:
                deletedItem = _meduimPrio[index];
                break;
            case 2:
                deletedItem = _lowPrio[index];
                break;
        }
    }
    else{
        deletedItem = _listView[index];

    }
    
    for(int i=0;i<_modelList.count;i++){
        if(_modelList[i].idNum == deletedItem.idNum ){
            [_modelList removeObjectAtIndex:i];
            break;
        }
    }
    
    
    [_toDoAppTasks removeObjectForKey:listName];
    NSError *error;
    NSData *dataRetrived = [NSKeyedArchiver archivedDataWithRootObject:self->_modelList requiringSecureCoding:YES error:&error];
    [_toDoAppTasks setObject:dataRetrived forKey:listName];
    [self loadModeList];
    [self filterDataAccordingToStatus:status withPredicate:condition];
    if(_isSort)
    [self filterAccordingPriority];
    
   

    
    
}
- (void)filterAccordingPriority {
    int priorityFilter = 0;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"prio == %d", priorityFilter];
    NSArray *filteredArray  = [_listView filteredArrayUsingPredicate:predicate];
    _highPrioty = [NSMutableArray arrayWithArray:filteredArray];
    priorityFilter = 1;
    predicate = [NSPredicate predicateWithFormat:@"prio == %d", priorityFilter];
    filteredArray = [_listView filteredArrayUsingPredicate:predicate];
    _meduimPrio = [NSMutableArray arrayWithArray:filteredArray];
    priorityFilter = 2;
    predicate = [NSPredicate predicateWithFormat:@"prio == %d", priorityFilter];
    filteredArray = [_listView filteredArrayUsingPredicate:predicate];
    _lowPrio = [NSMutableArray arrayWithArray:filteredArray];

}

@end
