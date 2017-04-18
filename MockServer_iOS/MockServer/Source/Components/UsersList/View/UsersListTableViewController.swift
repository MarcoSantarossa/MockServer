//
//  MockServer
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import UIKit

class UsersListTableViewController: BaseTableViewController<UsersListViewModel> {
    
    private struct Constants {
        static let cellIdentifier = "Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        viewModel.rx_userNames.bindTo(tableView.rx.items(cellIdentifier: Constants.cellIdentifier)) { index, model, cell in
                cell.textLabel?.text = model
            }
            .disposed(by: disposeBag)
    }
}
