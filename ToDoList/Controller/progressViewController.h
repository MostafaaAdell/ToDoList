//
//  progressViewController.h
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "ModelNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface progressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
//@property NSMutableArray<Model*> *modelList;
@property ModelNetwork *modelNetwork;
@end

NS_ASSUME_NONNULL_END
