//
//  ThemeTableViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import SafariServices

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ThemeManager.freeCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell", for: indexPath)
		
		let themeId = indexPath.row + indexPath.section * ThemeManager.freeCount
		
		cell.textLabel?.text = ThemeManager.getThemeName(themeId: themeId)

        return cell
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier != "themeDetailSegue" {
			return
		}
		
		//Preparation work before segue to ThemeDetailView
		let indexPath = tableView.indexPathForSelectedRow!
		let themeId = indexPath.row
		
		let themeDetailViewController = segue.destination as! ThemeDetailViewController
		themeDetailViewController.themeId = themeId
	}
    
    @IBAction func linkClicked(_ sender: Any) {
        let urlStr: String
        #if targetEnvironment(macCatalyst)
        urlStr = "https://apps.apple.com/jp/app/pro-table-tennis-scoreboard/id1484810163?mt=12"
        #else
        urlStr = "https://itunes.apple.com/us/app/pro-table-tennis-scoreboard/id1438386246?mt=8"
        #endif
        
        if let url = URL(string: urlStr) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
    }
}
