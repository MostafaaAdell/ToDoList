//
//  EditTaskViewController.h
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "ModelNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : UIViewController
@property Model  * taskDetails;
@property ModelNetwork *modelNetwork;
//@property NSInteger flag;
//@property NSMutableArray<Model *>*modelList;
@end

NS_ASSUME_NONNULL_END
