//
//  Model.h
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject<NSCoding,NSSecureCoding>


@property NSString *name,*desc;
@property int prio,status;
@property NSDate *date;
@property int idNum;

@end

NS_ASSUME_NONNULL_END
