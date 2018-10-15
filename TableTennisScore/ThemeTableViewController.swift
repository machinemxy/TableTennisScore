//
//  ThemeTableViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class ThemeTableViewController: UITableViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return ThemeController.freeCount
		} else {
			return ThemeController.chargedCount
		}
		
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return NSLocalizedString("Free", comment: "")
		} else {
			return NSLocalizedString("Charged", comment: "")
		}
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath)
		
		let themeId = indexPath.row + indexPath.section * ThemeController.freeCount
		
		cell.textLabel?.text = ThemeController.getThemeName(themeId: themeId)

        return cell
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier != "themeDetailSegue" {
			return
		}
		
		//Preparation work before segue to ThemeDetailView
		let indexPath = tableView.indexPathForSelectedRow!
		let themeId = indexPath.row + indexPath.section * ThemeController.freeCount
		
		let themeDetailViewController = segue.destination as! ThemeDetailViewController
		themeDetailViewController.themeId = themeId
	}
    
    @IBAction func linkClicked(_ sender: Any) {
        if let url = URL(string: "https://itunes.apple.com/us/app/pro-table-tennis-scoreboard/id1438386246?mt=8") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
