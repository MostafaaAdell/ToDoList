//
//  ViewController.m
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import "TODoListViewController.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"
#import "ModelNetwork.h"


@interface TODoListViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBartext;
@property (weak, nonatomic) IBOutlet UIToolbar *filterBySearch;
@property (weak, nonatomic) IBOutlet UITableView *tableListView;
@property ModelNetwork *modelNetwork;
@end

@implementation TODoListViewController{
    
    int status;
    NSString *predicateForStatus;
    NSString *predicateForSearch;
   
}


- (void)viewWillAppear:(BOOL)animated{
    
    [_modelNetwork loadModeList];
    [_modelNetwork filterDataAccordingToStatus:status withPredicate:predicateForStatus];
    [_tableListView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelNetwork = [ModelNetwork new];
    status = 0;
    predicateForStatus = @"status == %d";
    predicateForSearch = @"name CONTAINS[cd] %@";
    [_modelNetwork loadModeList];
    [_modelNetwork filterDataAccordingToStatus:status withPredicate:predicateForStatus];
    
 
    // Do any additional setup after loading the view.
}

//Done
- (IBAction)AddTask:(id)sender {
    
    AddTaskViewController *addTask = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTask"];
    addTask.modelNetwork.modelList = _modelNetwork.modelList;
    [self.navigationController pushViewController:addTask animated:YES];
    
    
}

//Done
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
//Done
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _modelNetwork.listView.count;
}

//Done
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
        cell.textLabel.text = _modelNetwork.listView[indexPath.row].name;

    
    return cell;
}

//Done
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTaskViewController *edittaskController = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTask"];
    edittaskController.modelNetwork.flag = 0;
    edittaskController.modelNetwork.modelList = _modelNetwork.modelList;
    edittaskController.taskDetails = _modelNetwork.listView[indexPath.row];
    [self.navigationController pushViewController:edittaskController animated:true];
    
}

//Done
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sure" message:@"You Want Delete Task" preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                         handler:nil];
         [alert addAction:cancelAction];
    
         UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
             [self->_modelNetwork removeCertainTaskWithIndex:(int)indexPath.row WithSection:(int)indexPath.section withStatus:(int)self->status withPredicate:self->predicateForStatus];
             
             [tableView reloadData];
         }];
         
         [alert addAction:okAction];
         [self presentViewController:alert animated:true completion:nil];
        

    }
}


//Done
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchText.length==0){
        [_modelNetwork loadModeList];
        [_modelNetwork filterDataAccordingToStatus:status withPredicate:predicateForStatus];
        [_tableListView reloadData];
    }else{
        [_modelNetwork filterDataAccordingToStatus:status withPredicate:predicateForSearch];
        [_tableListView reloadData];
    }
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [_modelNetwork loadModeList];
    [_modelNetwork filterDataAccordingToStatus:status withPredicate:predicateForStatus];
    [_tableListView reloadData];

}



@end
