//
//  ViewController.swift
//  expandableCell
//
//  Created by Randy Bannister on 18/08/2017.
//  Copyright © 2017 Randy Bannister. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sections = [
        Section(section: "section", rows: ["row","row"], expanded: true),
        Section(section: "section", rows: ["row","row"], expanded: false),
        Section(section: "section", rows: ["row","row"], expanded: false),
        Section(section: "section", rows: ["row","row"], expanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 44
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].section, section: section, delegate: self)
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        let rowIndex = indexPath.row
        
        cell.textLabel?.text = sections[indexPath.section].rows[rowIndex] + "\(rowIndex)"
        return cell
    }
}

extension ViewController: ExpandableHeaderViewDelegate {
    
    func toogleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].rows.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
}
