//
//  HomeTableViewController.swift
//  ARKitReference
//
//  Created by JOJI SAMUEL on 08/03/25.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.homeItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.HOME_TABLE_VIEW_CELL_ID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.homeItems[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: SegueIdentifiers.SCNGeometry, sender: nil)
        case 1:
            performSegue(withIdentifier: SegueIdentifiers.RollDice, sender: nil)
        case 2:
            performSegue(withIdentifier: SegueIdentifiers.Measure, sender: nil)
        default:
            break
        }
        
        
    }

}
