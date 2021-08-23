//
//  ViewController.swift
//  APIUser
//
//  Created by PC on 22/08/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var APIUserTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DataService.shared.fetchData { (result) in
            switch result {
            case .success(let gitData):
                for git in gitData {
                    print("\(git)\n")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func CreateNewGits(_ sender: UIButton) {
    
    }
    
    func showResultAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let startAction = UIContextualAction(style: .normal, title: "Star") { (action, view, completion) in
        
        completion(true)
        }
        let unstarAction = UIContextualAction(style: .normal, title: "Unstar") { (action, view, completion) in
            
            completion(true)
        }
        
        
        startAction.backgroundColor = .blue
        unstarAction.backgroundColor = .darkGray
        
        let actionConfig = UISwipeActionsConfiguration(actions: [startAction, unstarAction])
        return actionConfig
    }
    
}
