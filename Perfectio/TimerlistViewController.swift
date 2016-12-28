//
//  ViewController.swift
//  Perfectio
//
//  Created by Lim Oh Ju on 12/28/16.
//  Copyright © 2016 ohju. All rights reserved.
//

import UIKit

class TimerlistViewController: UITableViewController {
	
	var latestIndex: Int = 0
	var beforeIndex: Int = 0
	
	var items: [TimerlistItem]
	
	required init?(coder aDecoder: NSCoder) {
		items = [TimerlistItem]()
		
		let row0item = TimerlistItem()
		row0item.time = 50
		row0item.active = false
		items.append(row0item)
		
		let row1item = TimerlistItem()
		row1item.time = 500
		row0item.active = false
		items.append(row1item)
		
		let row2item = TimerlistItem()
		row2item.time = 5000
		row0item.active = false
		items.append(row2item)
		
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(_ tableView: UITableView,
	                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TimerlistItem", for: indexPath)
		let item = items[indexPath.row]
		configureTime(for: cell, with: item)
		configureActive(for: cell, with: item)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		latestIndexToBefore()
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = items[beforeIndex]
			item.time += 1
			item.active = false
			configureActive(for: cell, with: item)
			configureTime(for: cell, with: item)
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = items[indexPath.row]
			latestIndex = indexPath.row
			item.time -= 1
			item.toggleActive()
			item.active = true
			configureActive(for: cell, with: item)
			configureTime(for: cell, with: item)
		}
	}
	
	func configureTime(for cell: UITableViewCell, with item: TimerlistItem) {
		let label = cell.viewWithTag(1000) as! UILabel
		label.text = String(item.time)
	}
	
	func configureActive(for cell: UITableViewCell, with item: TimerlistItem) {
		if item.active {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
	}
	
	func latestIndexToBefore() {
		beforeIndex = latestIndex
	}
	
	
	
	
	
	
}
